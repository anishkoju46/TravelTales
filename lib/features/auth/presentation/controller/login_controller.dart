import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/nothing/dashboard.dart';

final loginNotifierProvider = NotifierProvider(LoginController.new);

class LoginController extends Notifier {
  final List<UserModel> userModel = [
    UserModel.generateUser(
      role: false,
      id: "2",
      email: "two@gmail.com",
      fullName: "Two",
      phoneNumber: "3333",
    ),
    UserModel.generateUser(
        role: false,
        id: "3",
        email: "Three@gmail.com",
        fullName: "Three",
        phoneNumber: "4444"),
    UserModel.generateUser(
        role: true,
        id: "4",
        email: "four@gmail.com",
        fullName: "Admin",
        phoneNumber: "1111")
  ];
  @override
  build() {}

  login(BuildContext context,
      {required String email, required String password}) {
    var index = userModel.indexWhere((e) =>
        e.userDetail.email == email && e.userDetail.phoneNumber == password);
    if (index == -1) return;

    ref.read(authNotifierProvider.notifier).login(
        // UserModel.generateUser(role: false, email: email),
        userModel[index]);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Dashboard();
    }));
  }
}
