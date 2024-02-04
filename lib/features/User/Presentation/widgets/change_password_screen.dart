import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFormController = ref.read(userFormProvider(userModel).notifier);
    final userFormState = ref.watch(userFormProvider(userModel));
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
            width: double.infinity,
            child: Row(
              children: [
                ArrowBackWidget(),
                Text(
                  "Change Password",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )
              ],
            ),
          ),
          Column(
            children: [
              Form(
                key: userFormController.formKey,
                child: Column(
                  children: [
                    feild(
                      initialValue: userFormState.fullName!,
                      label: "Old Password",
                      onchanged: (value) {
                        userFormController.update(fullName: value);
                      },
                    ),
                    feild(
                      label: "New Password",
                      //initialValue: userFormState.email!,
                      onchanged: (value) {
                        userFormController.update(email: value);
                      },
                    ),
                    feild(
                      label: "Old Password",
                      //initialValue: userFormState.phoneNumber!,
                      onchanged: (value) {
                        userFormController.update(phoneNumber: value);
                      },
                    ),
                    // if (ref.read(authNotifierProvider)!.role!) ...[
                    //   Row(
                    //     children: [
                    //       Text("ADMIN "),
                    //       Switch(
                    //           value: userFormState.role!,
                    //           onChanged: (value) {
                    //             userFormController.update(role: value);
                    //           }),
                    //     ],
                    //   ),
                    //   Row(
                    //     children: [
                    //       Text("BLOCK "),
                    //       Switch(
                    //           value: userFormState.block!,
                    //           onChanged: (value) {
                    //             userFormController.update(block: value);
                    //           }),
                    //     ],
                    //   )
                    // ]
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              customButton(
                  onPressed: () {}, iconData: Icons.close, string: "DISCARD"),
              customButton(
                  onPressed: () {
                    userFormController.handleSubmit(context);
                  },
                  iconData: Icons.done,
                  string: "SAVE")
            ],
          ),
        ],
      ),
    ));
  }

  Padding feild(
      {required String label,
      String? initialValue,
      required Function(String) onchanged,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        onChanged: (value) {
          onchanged(value);
        },
        initialValue: initialValue,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
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
