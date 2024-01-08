import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_async_list_controller.dart';
import 'package:traveltales/utility/form_controller.dart';

final destinationFormProvider = AutoDisposeNotifierProviderFamily<
    DestinationFormController,
    DestinationModel,
    DestinationModel?>(DestinationFormController.new);

class DestinationFormController extends FormController<DestinationModel> {
  @override
  DestinationModel build(DestinationModel? arg) {
    return arg ??
        DestinationModel(
            category: ref
                .read(CategoryNotifierProvider.notifier)
                .usableCategories
                .first);
  }

  @override
  update({
    String? name,
    String? description,
    String? itinerary,
    String? imageUrl,
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
      // itinerary: itinerary ?? state.itinerary,
      // imageUrl: imageUrl ?? state.imageUrl,
      region: region ?? state.region,
      duration: duration ?? state.duration,
      maxHeight: maxHeight ?? state.maxHeight,
      bestSeason: bestSeason ?? state.bestSeason,
      // coordinates: state.coordinates.copyWith(
      //     latitude: latitude ?? state.coordinates.latitude,
      //     longitude: longitude ?? state.coordinates.longitude),
      //category: category ?? state.category,
    );
  }

  @override
  handleSubmit(BuildContext context) {
    if (isValidated) {
      // print(state.length);
      if (state != arg) {
        ref.read(destinationListProvider.notifier).handleSubmit(state);
        //Navigator.pop(context);
        resetForm();
      } else {
        if (kDebugMode) {
          print("No changes Made");
        }
      }
    }
  }

  @override
  updateState() {
    // TODO: implement updateState
    throw UnimplementedError();
  }
}
