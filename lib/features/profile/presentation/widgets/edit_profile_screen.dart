import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/controller/login_controller.dart';
import 'package:traveltales/features/profile/presentation/controller/profile_controller.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Positioned(top: 10, left: 10, child: ArrowBackWidget()),
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                customTextFormField(
                    text: "Full Name",
                    iconData: Icons.person,
                    textEditingController:
                        ref.read(profileProvider.notifier).fullNameController
                          ..text = userModel.fullName),
                customTextFormField(
                    text: "Email",
                    iconData: Icons.email,
                    textEditingController:
                        ref.read(profileProvider.notifier).EmailController
                          ..text = userModel.userDetail.email.toString()),
                customTextFormField(
                    text: "Phone Number",
                    iconData: Icons.phone,
                    textEditingController:
                        ref.read(profileProvider.notifier).phoneController
                          ..text = userModel.userDetail.phoneNumber),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customButton(
                  onPressed: () {
                    ref.read(profileProvider.notifier).update(userModel);
                  },
                  iconData: Icons.done,
                  string: "Save"),
              customButton(
                  onPressed: () {}, iconData: Icons.close, string: "Discard")
            ],
          ),
          customButton(
              onPressed: () {
                ref.read(profileProvider.notifier).delete(userModel);
              },
              iconData: Icons.delete,
              string: "Deactivate ")
        ],
      ),
    ));
  }

  FilledButton customButton(
      {required Function onPressed,
      required IconData iconData,
      required String string}) {
    return FilledButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(iconData),
        label: Text(string));
  }

  Padding customTextFormField(
      {TextEditingController? textEditingController,
      required IconData iconData,
      required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: text,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
