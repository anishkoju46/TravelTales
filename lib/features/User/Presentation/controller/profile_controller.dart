import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/widgets/change_password_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/edit_profile_screen.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

final profileProvider =
    NotifierProvider<ProfileController, UserModel>(ProfileController.new);

class ProfileController extends Notifier<UserModel> {
  // final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController EmailController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  @override
  build() {
    throw UnimplementedError();
  }

  edit(BuildContext context) {
    final userModel = ref.read(authNotifierProvider);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfileScreen(
        userModel: userModel!,
      );
    }));
  }

  navigateToChangePasswordPage(BuildContext context) {
    final userModel = ref.read(authNotifierProvider);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChangePasswordScreen(userModel: userModel!);
    }));
  }

  // update(UserModel user) {
  //   ref.read(loginNotifierProvider.notifier).updateUser(user.copyWith(
  //       fullName: fullNameController.text,
  //       email: EmailController.text,
  //       phoneNumber: phoneController.text));
  // }

  // delete(UserModel user) {
  //   ref.read(loginNotifierProvider.notifier).deactivateUser(user.id!);
  // }
}
