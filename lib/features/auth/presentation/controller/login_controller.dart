import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/custom_snack.dart';

class LoginController extends AutoDisposeNotifier<
    ({String email, String password, bool showPassword})> {
  @override
  ({String email, String password, bool showPassword}) build() {
    return (email: "", password: "", showPassword: true);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController emailController =
      TextEditingController(text: state.email);
  late final TextEditingController passwordController =
      TextEditingController(text: state.password);

  login(
    BuildContext context,
  ) async {
    try {
      // print(state.password);
      // print(passwordController.text);
      await ref
          .read(authNotifierProvider.notifier)
          .login(context, email: state.email, password: state.password);
    } catch (e, s) {
      // print("$e $s");
      CustomSnack.error(context, message: e.toString());
    }
  }

  update({String? email, String? password, bool? showPassword}) {
    state = (
      email: email ?? state.email,
      password: password ?? state.password,
      showPassword: showPassword ?? state.showPassword
    );
  }

  updateFeild(String? email, String? password) {
    if (email != null) {
      emailController.text = email;
    }
    if (password != null) {
      passwordController.text = password;
    }
    update(email: email, password: password);
  }

  // updateUser(UserModel user) {
  //   final userList = ref.read(userListProvider);
  //   int index = userList.indexWhere((element) => element.id == user.id);
  //   if (index != -1) {
  //     state = [...state..[index] = user];
  //   }
  // }

  // deactivateUser(String index) {
  //   state = [...state]..remove(index);
  // }
}
