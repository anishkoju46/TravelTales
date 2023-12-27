import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFormController = ref.read(userFormProvider(userModel).notifier);
    final userFormState = ref.watch(userFormProvider(userModel));
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          ArrowBackWidget(),
          Form(
            key: userFormController.formKey,
            child: Column(
              children: [
                feild(
                  initialValue: userFormState.fullName,
                  label: "Full Name",
                  onchanged: (value) {
                    userFormController.update(fullName: value);
                  },
                ),
                feild(
                  label: "Email",
                  initialValue: userFormState.userDetail.email!,
                  onchanged: (value) {
                    userFormController.update(email: value);
                  },
                ),
                feild(
                  label: "Phone Number",
                  initialValue: userFormState.userDetail.phoneNumber,
                  onchanged: (value) {
                    userFormController.update(phoneNumber: value);
                  },
                ),
                if (ref.read(authNotifierProvider)!.role) ...[
                  Row(
                    children: [
                      Text("ADMIN "),
                      Switch(
                          value: userFormState.role,
                          onChanged: (value) {
                            userFormController.update(role: value);
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Text("BLOCK "),
                      Switch(
                          value: userFormState.block,
                          onChanged: (value) {
                            userFormController.update(block: value);
                          }),
                    ],
                  )
                ]
              ]
                  .map((e) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: e,
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customButton(
                  onPressed: () {
                    userFormController.handleSubmit(context);
                  },
                  iconData: Icons.done,
                  string: "Save"),
              customButton(
                  onPressed: () {}, iconData: Icons.close, string: "Discard")
            ],
          ),
          customButton(
              onPressed: () {}, iconData: Icons.delete, string: "Deactivate ")
        ],
      ),
    ));
  }

  TextFormField feild(
      {required String label,
      required String initialValue,
      required Function(String) onchanged,
      String? Function(String?)? validator}) {
    return TextFormField(
      onChanged: (value) {
        onchanged(value);
      },
      initialValue: initialValue,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
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

// customTextFormField(
//                     text: "Full Name",
//                     iconData: Icons.person,
//                     textEditingController:
//                         ref.read(profileProvider.notifier).fullNameController
//                           ..text = userModel.fullName),
//                 customTextFormField(
//                     text: "Email",
//                     iconData: Icons.email,
//                     textEditingController:
//                         ref.read(profileProvider.notifier).EmailController
//                           ..text = userModel.userDetail.email.toString()),
//                 customTextFormField(
//                     text: "Phone Number",
//                     iconData: Icons.phone,
//                     textEditingController:
//                         ref.read(profileProvider.notifier).phoneController
//                           ..text = userModel.userDetail.phoneNumber),
