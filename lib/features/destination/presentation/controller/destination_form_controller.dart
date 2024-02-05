import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/form_controller.dart';

class DestinationFormController extends FormController<DestinationModel> {
  @override
  DestinationModel build(DestinationModel? arg) {
    final category = ref.read(categoryListProvider.notifier).usableCategories;
    return arg ??
        DestinationModel(category: category.isEmpty ? null : category.first);
  }

  @override
  update({
    String? name,
    String? description,
    List<String>? itinerary,
    List<String>? imageUrl,
    String? region,
    String? duration,
    String? maxHeight,
    String? bestSeason,
    double? latitude,
    double? longitude,
    CategoryModel? category,
  }) {
    state = state.copyWith(
      name: name ?? state.name,
      description: description ?? state.description,
      itinerary: itinerary ?? state.itinerary,
      imageUrl: imageUrl ?? state.imageUrl,
      region: region ?? state.region,
      duration: duration ?? state.duration,
      maxHeight: maxHeight ?? state.maxHeight,
      bestSeason: bestSeason ?? state.bestSeason,
      coordinates: state.coordinates != null
          ? state.coordinates?.copyWith(coordinates: [
              longitude ?? state.coordinates!.coordinates!.first,
              latitude ?? state.coordinates!.coordinates!.last
            ])
          : Coordinates(coordinates: [longitude ?? 0.0, latitude ?? 0.0]),
      category: category ?? state.category,
    );
  }

  @override
  handleSubmit(BuildContext context, {bool isAdd = false}) async {
    if (isValidated) {
      // print(state.length);
      if (state != arg) {
        try {
          final repository = DestinationRepository(
              token: ref.watch(authNotifierProvider)?.token);
          if (isAdd) {
            final destination =
                await repository.addDestination(destination: state);
            ref
                .read(destinationListProvider.notifier)
                .handleSubmit(destination);
            CustomSnack.success(context, message: "Destination Added");
          } else {
            final destination =
                await repository.editDestination(destination: state);
            ref
                .read(destinationListProvider.notifier)
                .handleSubmit(destination);
            CustomSnack.success(context, message: "Destination Edited");
          }
        } catch (e, s) {
          CustomSnack.error(context, message: e.toString());
          print(e);
          print(s);
        }
        //Navigator.pop(context);
        resetForm();
      } else {
        CustomSnack.info(context, message: "No changes Made");
      }
    }
  }

  @override
  updateState() {
    // TODO: implement updateState
    throw UnimplementedError();
  }
}
