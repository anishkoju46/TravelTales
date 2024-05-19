import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/validator.dart';

class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key, this.userModel});
  final UserModel? userModel;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Change Password",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Form(
                //key: userFormController.formKey,
                child: Column(
                  children: [
                    CustomTextFormFeild(
                        credentials: "Current Password",
                        controller: currentPasswordController,
                        onchanged: (value) {},
                        validator: passwordValidator),
                    CustomTextFormFeild(
                        credentials: "New Password",
                        controller: newPasswordController,
                        onchanged: (value) {},
                        validator: passwordValidator),
                    CustomTextFormFeild(
                      credentials: "Confirm Password",
                      controller: confirmNewPasswordController,
                      onchanged: (value) {},
                      validator: passwordValidator,
                    ),
                  ]
                      .map((e) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: e,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
          FilledButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertBox(
                        confirmText: "Confirm",
                        onPressed: () {
                          ref.read(userListProvider.notifier).changePassword(
                              context,
                              currentPassword: currentPasswordController.text,
                              newPassword: newPasswordController.text,
                              confirmPassword:
                                  confirmNewPasswordController.text);

                          Navigator.pop(context);

                          // AlertBox(
                          //     confirmText: "Logout",
                          //     onPressed: () {
                          //       ref
                          //           .watch(authNotifierProvider.notifier)
                          //           .logout(context);
                          //     },
                          //     title: "Do you want to Logout?");
                        },
                        title: "Save Changes");
                  },
                );
                // Navigator.pop(context);
              },
              child: Text("Save Changes"))
        ],
      ),
    ));
  }
}
