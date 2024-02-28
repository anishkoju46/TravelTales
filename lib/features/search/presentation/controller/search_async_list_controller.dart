import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/search/data/repository/search_repository.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/repository.dart';

class SearchingController extends AsyncListController<DestinationModel> {
  final ScrollController listScrollController = ScrollController();
  DestinationModel? currentDestination;

  @override
  bool findById(DestinationModel element,
      [DestinationModel? current, String? id]) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Widget formWidget(DestinationModel? model) {
    // TODO: implement formWidget
    throw UnimplementedError();
  }

  @override
  List<DestinationModel> fromStorage(String data) {
    // TODO: implement fromStorage
    throw UnimplementedError();
  }

  @override
  // TODO: implement respository
  Repository<DestinationModel> get respository => throw UnimplementedError();

  @override
  String toStorage() {
    // TODO: implement toStorage
    throw UnimplementedError();
  }

  Future<List<DestinationModel>> searchDestination(BuildContext context,
      {required String query}) async {
    try {
      List<DestinationModel> result =
          await SearchRepository(token: ref.watch(authNotifierProvider)?.token)
              .searchDestination(query: query);
      CustomSnack.success(context, message: "Filtered Destination");
      return result;
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
      throw e;
    }
  }
}
