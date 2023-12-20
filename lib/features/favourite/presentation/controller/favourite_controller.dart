import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

final favouriteStorage = GetStorage();

final favouriteProvider =
    NotifierProvider<FavouriteController, Map<String, DestinationModel>>(
        FavouriteController.new);

class FavouriteController extends Notifier<Map<String, DestinationModel>> {
  final favouriteKey = "Favourite";
  @override
  Map<String, DestinationModel> build() {
    var fav = favouriteStorage.read(favouriteKey);
    if (fav != null) {
      List<DestinationModel> list = destinationModelFromJson(fav);
      return {for (var e in list) e.id: e};
    } else {
      return {};
    }
    //state persistance, so that like gareko kura reload garda ni basos
  }

  addToFavourite(DestinationModel destination) {
    state = {...state..putIfAbsent(destination.id, () => destination)};
    var value = state.values.toList();
    favouriteStorage.write(favouriteKey, destinationModelToJson(value));
  }

  removeFromFavourite(String id) {
    state = {...state..remove(id)};
    favouriteStorage.write(
        favouriteKey, destinationModelToJson(state.values.toList()));
  }

  showByFavourite() {}

  showFavouriteDetails() {}

  favouriteColorSwitcher(bool isFavourite) {}

  handleFavourite(DestinationModel destination) {
    if (state.containsKey(destination.id)) {
      removeFromFavourite(destination.id);
    } else {
      addToFavourite(destination);
    }
  }
}
