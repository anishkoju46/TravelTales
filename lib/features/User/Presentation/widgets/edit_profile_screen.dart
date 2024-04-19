import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/validator.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key, required this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFormController = ref.read(userFormProvider(userModel).notifier);
    final userFormState = ref.watch(userFormProvider(userModel));
    final isCurrentUser = ref.read(authNotifierProvider)!.id != userModel?.id;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              "Edit Profile",
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
                    key: userFormController.formKey,
                    child: Column(
                      children: [
                        CustomTextFormFeild(
                            initialValue: userFormState.fullName!,
                            credentials: "Full Name",
                            iconData: Icons.person,
                            onchanged: (value) {
                              userFormController.update(fullName: value);
                            },
                            readOnly: isCurrentUser == true ? true : false,
                            validator: fullNameValidator),
                        CustomTextFormFeild(
                            initialValue: userFormState.email!,
                            credentials: "Email",
                            iconData: Icons.email,
                            onchanged: (value) {
                              userFormController.update(email: value);
                            },
                            readOnly: isCurrentUser == true ? true : false,
                            validator: emailValidator),
                        CustomTextFormFeild(
                            credentials: "Phone Number",
                            iconData: Icons.phone,
                            initialValue: userFormState.phoneNumber!,
                            onchanged: (value) {
                              userFormController.update(phoneNumber: value);
                            },
                            readOnly: isCurrentUser == true ? true : false,
                            validator: phoneNumberValidator),
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
              Column(
                children: [
                  customButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertBox(
                                  confirmText: "Confirm",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    userFormController.handleSubmit(context);
                                  },
                                  title: "Save Changes");
                            });
                      },
                      iconData: Icons.published_with_changes,
                      string: "Save Changes"),
                ],
              ),
            ],
          ),
          floatingActionButton: isCurrentUser
              ? Container()
              : ElevatedButton(
                  onPressed: () {
                    customAlertDialog(context, ref, userFormState,
                        confirmText: "Yes", onPressed: () {
                      customAlertDialog(context, ref, userFormState,
                          title: "Are you sure?", onPressed: () async {
                        await UserRepository(
                                token: ref.read(authNotifierProvider)?.token)
                            .blockUser(id: userFormState.id!);
                        await ref
                            .watch(authNotifierProvider.notifier)
                            .logout(context);

                        CustomSnack.error(context,
                            message: "Account Deactivated!");
                      },
                          confirmText: "I Agree",
                          subtitle:
                              "Once deactivated, only Admin can reactivate this account");
                    },
                        subtitle: "Do you want to Deactivate your account?",
                        title: "Warning!!");
                  },
                  child: Text("Deactivate"))),
    );
  }

  Future<dynamic> customAlertDialog(
    BuildContext context,
    WidgetRef ref,
    UserModel userFormState, {
    required String title,
    required Function onPressed,
    required String confirmText,
    required String subtitle,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          actions: [
            Column(
              children: [
                Text(textAlign: TextAlign.center, subtitle),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text("Discard"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onPressed();
                          //Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(confirmText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// AlertBox(
//             confirmText: "Confirm",
//             onPressed: () async {
//               await UserRepository(token: ref.read(authNotifierProvider)?.token)
//                   .blockUser(id: userFormState.id!);
//               await ref.watch(authNotifierProvider.notifier).logout(context);
//             },
//             title:
//                 "WARNING!!\nOnce deactivated, only Admin can reactivate this account");

  // Padding feild(
  //     {required String label,
  //     required IconData icondata,
  //     required String initialValue,
  //     required Function(String) onchanged,
  //     String? Function(String?)? validator,
  //     bool readOnly = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
  //     child: TextFormField(
  //       readOnly: readOnly,
  //       onChanged: (value) {
  //         onchanged(value);
  //       },
  //       initialValue: initialValue,
  //       validator: validator,
  //       decoration: InputDecoration(
  //         suffixIcon: Icon(icondata),
  //         labelText: label,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
}
