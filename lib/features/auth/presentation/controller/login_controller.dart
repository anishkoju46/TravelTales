import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/dashboard/presentation/admin_dashboard/widgets/admin_dashboard.dart';
import 'package:traveltales/features/dashboard/presentation/user_dashboard/widgets/user_dashboard.dart';

final loginNotifierProvider = NotifierProvider(LoginController.new);

class LoginController extends Notifier {
  // final List<UserModel> userModel = [
  //   UserModel.generateUser(
  //       role: false,
  //       id: "2",
  //       email: "two@gmail.com",
  //       fullName: "Two",
  //       phoneNumber: "2222",
  //       imageUrl: "assets/images/icon.jpeg"),
  //   UserModel.generateUser(
  //       role: false,
  //       id: "3",
  //       email: "three@gmail.com",
  //       fullName: "Three",
  //       phoneNumber: "3333"),
  //   UserModel.generateUser(
  //       role: true,
  //       id: "4",
  //       email: "four@gmail.com",
  //       fullName: "Admin",
  //       phoneNumber: "4444",
  //       imageUrl: "assets/images/aa.jpg")
  // ];
  @override
  build() {}

  login(BuildContext context,
      {required String email, required String password}) {
    final user = ref.read(userListProvider);
    var index = user.indexWhere((e) =>
        e.userDetail.email == email && e.userDetail.phoneNumber == password);
    if (index == -1) return;

    ref.read(authNotifierProvider.notifier).login(
        // UserModel.generateUser(role: false, email: email),
        user[index]);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return ref.read(authNotifierProvider)!.role
          ? AdminDashboard()
          : UserDashboard();
    }));
  }

  updateUser(UserModel user) {
    final userList = ref.read(userListProvider);
    int index = userList.indexWhere((element) => element.id == user.id);
    if (index != -1) {
      state = [...state..[index] = user];
    }
  }

  deactivateUser(String index) {
    state = [...state]..remove(index);
  }
}
