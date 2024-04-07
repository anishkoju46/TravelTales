import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';
import 'package:traveltales/features/dashboard/presentation/admin_dashboard/widgets/admin_dashboard.dart';
import 'package:traveltales/features/dashboard/presentation/user_dashboard/widgets/user_dashboard.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/repository.dart';

final storage = GetStorage();

class AuthController extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return loadUser();
  }

  final key = "currentUser";

  UserModel? loadUser() {
    final storedUser = storage.read(key);

    if (storedUser == null) return null;

    final user = UserModel.fromRawJson(storedUser);

    return user;
  }

  // init(BuildContext context) async {
  //   if (state == null) {
  //     return Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => LoginScreen(),
  //         ));
  //   }
  //   //loginWithToken();

  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const UserDashboard(),
  //       ));
  // }

  // loginWithToken() async {
  //   if (state?.token != null) {
  //     state = await AuthRepository(token: state?.token).login();
  //   }
  // }

  login(BuildContext context,
      {required String email, required String password}) async {
    final client = await ref.getDebouncedHttpClient();

    // state =
    final user = await AuthRepository(client: client)
        .login(email: email, password: password);

    // print(user.toJson());

    state = user;

    // print(state!.toJson());

    storage.write(key, state?.toRawJson());
    // print(state!.toJson());

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  state!.role! ? AdminDashboard() : UserDashboard()));
    });
  }

  signUp(BuildContext context,
      {required String fullName,
      required String email,
      required String phoneNumber,
      required String password}) async {
    final client = await ref.getDebouncedHttpClient();
    await AuthRepository(client: client).signUp(
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber);
    Navigator.pop(context);
    ref
        .read(loginNotifierProvider.notifier)
        .update(email: email, password: password);
  }

  // bool get role => state!.role!;

  loader(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return state == null
                  ? LoginScreen()
                  : state!.role!
                      ? AdminDashboard()
                      : UserDashboard();
            },
          ),
        );
      },
    );
  }

  logout(BuildContext context) {
    ref.read(favouriteProvider.notifier).clearFavourites();
    storage.remove(key);
    state = null;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  update(UserModel user) {
    state = state!.copyWith(
        fullName: user.fullName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        favourites: user.favourites,
        imageUrl: user.imageUrl,
        gallery: user.gallery);
    storage.write(key, state?.toRawJson(false));
  }

  String getImageUrl() {
    final baseUrl = AuthRepository().baseUrl;
    return "${baseUrl}${state?.imageUrl!.replaceAll('\\', '/')}";
  }

  String getGalleryImageUrls(int index) {
    final baseUrl = AuthRepository().baseUrl;
    return "${baseUrl}${state?.gallery![index].replaceAll('\\', '/')}";
  }

  String getGalleryImageUrlForDeletion(int index) {
    return "${state?.gallery![index]}";
  }

  // List<String> getGalleryImageUrls() {
  //   final baseUrl = AuthRepository().baseUrl;
  //   List<String> imageUrls = [];

  //   Check if state and gallery are not null
  //   if (state != null && state!.gallery != null) {
  //   Iterate through the gallery list
  //   for (String imagePath in state!.gallery!) {
  //     Concatenate the base URL with each image path, replacing backslashes if any
  //     imageUrls.add("${baseUrl}${imagePath.replaceAll('\\', '/')}");
  //   }
  //   }

  //   return imageUrls;
  // }

  // login([UserModel? user]) {
  //   //to do: check if the user model is null or not
  //   //state ma vako lai rawjason use gareera getStorage ma save garnu paryo

  //   //TODO
  //   //state = user ?? UserModel.generateUser(role: false);
  //   storage.write("key", state!.toRawJson());
  // }

  // signOut(BuildContext context) {
  //   //remove key
  //   state = null;
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return Loader();
  //       },
  //     ),
  //   );
  //   storage.remove(key);
  // }
}



//email + password
//login ra sign up ma textediting controller
//ani login garda .gerenate garera text ko emial ma j theeao tei pass garne

//3 ota user banaune ani tei aanusar tini haruko login garne

//get storage use garne
