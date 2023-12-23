import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_list_controller.dart';

final destinationFormProvider = AutoDisposeNotifierProviderFamily<
    DestinationFormController,
    DestinationModel,
    DestinationModel?>(DestinationFormController.new);

class DestinationFormController
    extends AutoDisposeFamilyNotifier<DestinationModel, DestinationModel?> {
  @override
  DestinationModel build(DestinationModel? arg) {
    return arg ?? DestinationModel.empty();
  }

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
    String? categoryName,
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
      coordinates: state.coordinates.copyWith(
          latitude: latitude ?? state.coordinates.latitude,
          longitude: longitude ?? state.coordinates.longitude),
      category: state.category.copyWith(
        name: categoryName ?? state.category.name,
      ),
      // review: [...state.review]
    );
  }

  handleSubmit(BuildContext context) {
    if (formkey.currentState!.validate()) {
      if (state != arg) {
        ref.read(destinationListProvider.notifier).handelSubmit(state);
        Navigator.pop(context);
      } else {
        if (kDebugMode) {
          print("No changes Made");
        }
      }
    }
  }
}
