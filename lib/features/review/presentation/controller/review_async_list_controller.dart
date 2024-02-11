import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/review/data/repository/review_repository.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/repository.dart';

class ReviewController extends AsyncListController<ReviewModel> {
  final ScrollController listScrollController = ScrollController();

  @override
  Widget formWidget(ReviewModel? model) {
    // TODO: implement formWidget
    throw UnimplementedError();
  }

  @override
  List<ReviewModel> fromStorage(String data) => reviewModelFromJson(data);

  @override
  Repository<ReviewModel> get respository =>
      ReviewRepository(token: ref.watch(authNotifierProvider)?.token);

  @override
  String toStorage() => reviewModelToJson(state.value!);

  @override
  Future<List<ReviewModel>> fetchData() async {
    final destination =
        ref.read(destinationListProvider.notifier).currentDestination;
    if (destination == null) {
      return super.fetchData();
    }
    return await ReviewRepository(token: ref.watch(authNotifierProvider)?.token)
        .fetchByDestination(id: destination.id);
  }

  @override
  bool findById(ReviewModel element, [ReviewModel? current, String? id]) {
    return element.id == ((current?.id) ?? id);
  }
}
