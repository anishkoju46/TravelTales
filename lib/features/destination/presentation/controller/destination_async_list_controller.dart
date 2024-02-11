import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_dashboard.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/repository.dart';

class DestinationController extends AsyncListController<DestinationModel> {
  final ScrollController listScrollController = ScrollController();
  DestinationModel? currentDestination;

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
      BuildContext context, DestinationModel destinationModel) async {
    currentDestination = destinationModel;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return DestinationDashboard(destinationModel: destinationModel);
        },
      ),
    );
    currentDestination = null;
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
      CustomSnack.success(context, message: "Destination Deleted");
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }

  updateDestinationWithModel() {}

  @override
  bool findById(DestinationModel element,
      [DestinationModel? current, String? id]) {
    return element.id == ((current?.id) ?? id);
  }

  // setDestination(
  //   String id,
  // ) {
  //   updateWithModel(id, onFoundModel: (foundModel) {
  //     return foundModel.copyWith(id: id);
  //   });
  // }
}
