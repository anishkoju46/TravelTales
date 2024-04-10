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
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> emergencyContact(String phoneNumber) async {
    final String phoneNumberWithCountryCode = "+977$phoneNumber";
    final Uri phoneLaunchUri =
        Uri(scheme: 'tel', path: phoneNumberWithCountryCode);
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }

  searchDestination(BuildContext context, {required String query}) async {
    try {
      final List<DestinationModel> searchResult = await DestinationRepository(
              token: ref.watch(authNotifierProvider)?.token)
          .searchDestination(query: query);

      state = AsyncValue.data(searchResult);
      CustomSnack.success(context, message: "Filtered Destination");
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }

  String parseImage({required String path}) {
    final baseUrl = DestinationRepository().baseUrl;
    return "${baseUrl}${path.replaceAll('\\', '/')}";
  }

  // searchDestination(BuildContext context, {required String query}) async {
  //   try {
  //     await DestinationRepository(token: ref.watch(authNotifierProvider)?.token)
  //         .searchDestination(query: query);
  //     CustomSnack.success(context, message: "Filtered Destination");
  //   } catch (e, s) {
  //     CustomSnack.error(context, message: e.toString());
  //   }
  // }

  // setDestination(
  //   String id,
  // ) {
  //   updateWithModel(id, onFoundModel: (foundModel) {
  //     return foundModel.copyWith(id: id);
  //   });
  // }
}
