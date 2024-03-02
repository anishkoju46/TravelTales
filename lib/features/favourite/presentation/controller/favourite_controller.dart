import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/utility/custom_snack.dart';

final favouriteStorage = GetStorage();

final favouriteProvider = NotifierProvider.autoDispose<FavouriteController,
    Map<String, DestinationModel>>(FavouriteController.new);

class FavouriteController
    extends AutoDisposeNotifier<Map<String, DestinationModel>> {
  final favouriteKey = "currentUser";

  @override
  Map<String, DestinationModel> build() {
    // var fav = favouriteStorage.read(favouriteKey);
    // if (fav != null) {
    //   final favv = jsonDecode(fav);

    //   List<DestinationModel> list = List<DestinationModel>.from(
    //       favv['favourites'].map((x) => DestinationModel.fromJson(x)));

    //   return {for (var e in list) e.id!: e};
    // } else {
    //   return {};
    // }
    //state persistance, so that like gareko kura reload garda ni basos
    final user = ref.watch(authNotifierProvider);
    // print(user!.toRawJson());
    final favMap = {for (var e in user!.favourites!) e.id!: e};
    // print(favMap);
    return favMap;
  }

  addToFavourite(DestinationModel destination) {
    state = {...state..putIfAbsent(destination.id!, () => destination)};
    var value = state.values.toList();
    favouriteStorage.write(favouriteKey, destinationModelToJson(value));
  }
  //Map banaunu paryo!! id ma user id, value ma model

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
      removeFromFavourite(destination.id!);
    } else {
      addToFavourite(destination);
    }
  }

  toggleFavourites(BuildContext context, DestinationModel destination,
      bool isFavourites) async {
    try {
      final fav =
          await UserRepository(token: ref.watch(authNotifierProvider)?.token)
              .toggleFavourites(id: destination.id!);
      CustomSnack.success(context,
          message:
              isFavourites ? "Removed from Favourites" : "Added to Favourites");
      if (isFavourites) {
        //fav lai list bata hataunu paryo
        //state bata id vako item bata index nikalne
        state = {...state..remove(destination.id)};
        updateFavouritesInStorage();
      } else {
        state = {...state..putIfAbsent(destination.id!, () => destination)};
        updateFavouritesInStorage();
      }
    } catch (e, s) {
      // print("E for Error: $e");
      // print("S for S-Error: $s");
      CustomSnack.error(context, message: e.toString());
    }
  }

  updateFavouritesInStorage() {
    final currentUser = ref.read(authNotifierProvider);
    ref
        .read(authNotifierProvider.notifier)
        .update(currentUser!.copyWith(favourites: state.values.toList()));
  }

  clearFavourites() {
    state = {};
  }
}
