import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_dashboard.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/repository.dart';

final destinationListProvider = AsyncNotifierProvider.autoDispose<
    DestinationController, List<DestinationModel>>(DestinationController.new);

class DestinationController extends AsyncListController<DestinationModel> {
  final ScrollController listScrollController = ScrollController();

  @override
  bool findById(DestinationModel element, DestinationModel current) =>
      element.id == current.id;

  @override
  Widget formWidget(DestinationModel? model) =>
      DestinationForm(destination: model);

  @override
  List<DestinationModel> fromStorage(String data) =>
      destinationModelFromJson(data);

  @override
  Repository<DestinationModel> get respository =>
      DestinationRepository(token: ref.watch(authNotifierProvider)?.token);

  @override
  String toStorage() => destinationModelToJson(state.value!);

  showDestinationDetails(
      BuildContext context, DestinationModel destinationModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DestinationDashboard(destinationModel: destinationModel);
        },
      ),
    );
  }

  @override
  Future<List<DestinationModel>> fetchData() {
    return DestinationRepository(token: ref.watch(authNotifierProvider)?.token)
        .fetchByCategory(id: ref.watch(CategoryNotifierProvider)?.id);
  }

  delete(BuildContext context, DestinationModel destination) async {
    try {
      await DestinationRepository(token: ref.watch(authNotifierProvider)?.token)
          .delete(destination.id!);
      remove(destination);
      CustomSnack.error(context, message: "Destination Deleted");
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }
}
