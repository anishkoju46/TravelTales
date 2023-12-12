import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';
import 'package:traveltales/utility/loader.dart';

final authNotifierProvider =
    NotifierProvider<AuthController, UserModel?>(AuthController.new);

class AuthController extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return null;
  }

  login([UserModel? user]) {
    state = user ?? UserModel.generateUser(role: false);
  }

  signOut(BuildContext context) {
    state = null;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Loader();
    }));
  }

  bool get role => state!.role;
}

//email + password
//login ra sign up ma textediting controller
//ani login garda .gerenate garera text ko emial ma j theeao tei pass garne

//3 ota user banaune ani tei aanusar tini haruko login garne


