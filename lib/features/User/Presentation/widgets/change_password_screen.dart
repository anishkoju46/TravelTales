import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/validator.dart';

class ChangePasswordScreen extends ConsumerWidget {
  const ChangePasswordScreen({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final userFormController = ref.read(userFormProvider(userModel).notifier);
    // final userFormState = ref.watch(userFormProvider(userModel));
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
                //key: userFormController.formKey,
                child: Column(
                  children: [
                    CustomTextFormFeild(
                        credentials: "Old Password",
                        onchanged: (value) {},
                        validator: passwordValidator),
                    CustomTextFormFeild(
                        credentials: "New Password",
                        onchanged: (value) {},
                        validator: passwordValidator),
                    CustomTextFormFeild(
                        credentials: "Confirm Password",
                        onchanged: (value) {},
                        validator: passwordValidator),
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
                          Navigator.pop(context);
                        },
                        title: "Save Changes");
                  },
                );
              },
              child: Text("Save Changes"))
        ],
      ),
    ));
  }
}
