import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';
import 'package:traveltales/features/dashboard/presentation/dashboard.dart';
import 'package:traveltales/utility/loader.dart';

final storage = GetStorage();

final authNotifierProvider =
    NotifierProvider<AuthController, UserModel?>(AuthController.new);

class AuthController extends Notifier<UserModel?> {
  final String key = "key";
  @override
  UserModel? build() {
    var user = storage.read(key);
    if (user != null) {
      return UserModel.fromRawJson(user);
    }
    return null;
  }

  login([UserModel? user]) {
    //to do: check if the user model is null or not
    //state ma vako lai rawjason use gareera getStorage ma save garnu paryo

    state = user ?? UserModel.generateUser(role: false);
    storage.write("key", state!.toRawJson());
  }

  signOut(BuildContext context) {
    //remove key
    state = null;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Loader();
        },
      ),
    );
    storage.remove(key);
  }

  bool get role => state!.role;

  loader(BuildContext context) {
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return state == null ? LoginScreen() : Dashboard();
            },
          ),
        );
      },
    );
  }
}

//email + password
//login ra sign up ma textediting controller
//ani login garda .gerenate garera text ko emial ma j theeao tei pass garne

//3 ota user banaune ani tei aanusar tini haruko login garne

//get storage use garne
