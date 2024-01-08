import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/custom_snack.dart';

class SignUpController extends AutoDisposeNotifier<
    ({
      String fullName,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword,
      bool showPassword,
      bool showConfirmPassword,
    })> {
  @override
  ({
    String email,
    String fullName,
    String password,
    String phoneNumber,
    String confirmPassword,
    bool showPassword,
    bool showConfirmPassword
  }) build() {
    return (
      email: "",
      fullName: "",
      password: "",
      phoneNumber: "",
      confirmPassword: "",
      showPassword: true,
      showConfirmPassword: true
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  signUp(BuildContext context) async {
    try {
      if (formKey.currentState!.validate()) {
        if (state.password == state.confirmPassword) {
          await ref.read(authNotifierProvider.notifier).signUp(context,
              email: state.email,
              password: state.password,
              fullName: state.fullName,
              phoneNumber: state.phoneNumber);

          CustomSnack.success(context, message: "Sucessfully Registered");
          ref
              .read(loginNotifierProvider.notifier)
              .updateFeild(state.email, state.password);
        } else {
          CustomSnack.error(context, message: "Password Mismatched");
        }
      }
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }

  update(
      {String? email,
      String? password,
      String? fullName,
      String? confirmPassword,
      String? phoneNumber,
      bool? showPassword,
      bool? showConfirmPassword}) {
    state = (
      email: email ?? state.email,
      password: password ?? state.password,
      fullName: fullName ?? state.fullName,
      confirmPassword: confirmPassword ?? state.confirmPassword,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      showPassword: showPassword ?? state.showPassword,
      showConfirmPassword: showConfirmPassword ?? state.showConfirmPassword
    );
  }
}
