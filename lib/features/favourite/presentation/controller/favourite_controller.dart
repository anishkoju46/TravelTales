import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';

const favouriteKey = "Favourite";

final favouriteProvider =
    NotifierProvider<FavouriteController, Map<String, DestinationModel>>(
        FavouriteController.new);

class FavouriteController extends Notifier<Map<String, DestinationModel>> {
  @override
  Map<String, DestinationModel> build() {
    return {};
    //state persistance, so that like gareko kura reload garda ni basos
  }

  addToFavourite(DestinationModel destination) {
    state = {...state..putIfAbsent(destination.id, () => destination)};
  }

  removeFromFavourite(String id) {
    state = {...state..remove(id)};
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
