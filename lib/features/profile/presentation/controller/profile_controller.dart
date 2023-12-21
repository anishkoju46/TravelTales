import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/auth/presentation/controller/login_controller.dart';
import 'package:traveltales/features/profile/presentation/widgets/edit_profile_screen.dart';

final profileProvider =
    NotifierProvider<ProfileController, UserModel>(ProfileController.new);

class ProfileController extends Notifier<UserModel> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  build() {
    throw UnimplementedError();
  }

  navigateToEditPage(BuildContext context) {
    final userModel = ref.read(authNotifierProvider);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfileScreen(
        userModel: userModel!,
      );
    }));
  }

  update(UserModel user) {
    ref.read(loginNotifierProvider.notifier).updateUser(user.copyWith(
        fullName: fullNameController.text,
        userDetail: user.userDetail.copyWith(
            email: EmailController.text, phoneNumber: phoneController.text)));
  }

  delete(UserModel user) {
    ref.read(loginNotifierProvider.notifier).deactivateUser(user.id);
  }
}
