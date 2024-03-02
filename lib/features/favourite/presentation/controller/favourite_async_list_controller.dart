// // class FavouriteController extends Async

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:traveltales/features/User/Data/user_repository.dart';
// import 'package:traveltales/features/auth/presentation/state/state.dart';
// import 'package:traveltales/features/destination/domain/destination_model_new.dart';
// import 'package:traveltales/utility/async_list_controller.dart';
// import 'package:traveltales/utility/custom_snack.dart';
// import 'package:traveltales/utility/repository.dart';

// final Storage = GetStorage;

// final favouriteListProvider = AsyncNotifierProvider.autoDispose<
//     FavouriteAsyncListController,
//     List<DestinationModel>>(FavouriteAsyncListController.new);

// class FavouriteAsyncListController
//     extends AsyncListController<DestinationModel> {
//   @override
//   bool findById(DestinationModel element,
//       [DestinationModel? current, String? id]) {
//     // TODO: implement findById
//     throw UnimplementedError();
//   }

//   @override
//   Widget formWidget(DestinationModel? model) {
//     // TODO: implement formWidget
//     throw UnimplementedError();
//   }

//   @override
//   List<DestinationModel> fromStorage(String data) {
//     // TODO: implement fromStorage
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement respository
//   Repository<DestinationModel> get respository => throw UnimplementedError();

//   @override
//   String toStorage() {
//     // TODO: implement toStorage
//     throw UnimplementedError();
//   }

//   toggleFavourites(BuildContext context, DestinationModel destination) async {
//     try {
//       final fav =
//           await UserRepository(token: ref.watch(authNotifierProvider)?.token)
//               .toggleFavourites(id: destination.id!);
//       CustomSnack.success(context, message: "");

//       print(fav);

//       // final currentUser = ref.watch(authNotifierProvider);

//       // if (currentUser!.favourites!.any((fav) => fav.id != destination.id)) {
//       //   CustomSnack.success(context, message: "Added to Favourites");
//       // } else {
//       //   CustomSnack.info(context, message: "Removed from Favourites");
//       // }
//     } catch (e, s) {
//       // print("E for Error: $e");
//       // print("S for S-Error: $s");
//       CustomSnack.error(context, message: e.toString());
//     }
//   }
// }
