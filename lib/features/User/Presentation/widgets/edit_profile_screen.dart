import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
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
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: Theme.of(context).colorScheme.primary,
              width: double.infinity,
              child: Row(
                children: [
                  ArrowBackWidget(),
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              )),
          Column(
            children: [
              Form(
                key: userFormController.formKey,
                child: Column(
                  children: [
                    feild(
                        initialValue: userFormState.fullName!,
                        label: "Full Name",
                        icondata: Icons.person,
                        onchanged: (value) {
                          userFormController.update(fullName: value);
                        },
                        readOnly: isCurrentUser == true ? true : false,
                        validator: fullNameValidator),
                    feild(
                        label: "Email",
                        icondata: Icons.email,
                        initialValue: userFormState.email!,
                        onchanged: (value) {
                          userFormController.update(email: value);
                        },
                        readOnly: isCurrentUser == true ? true : false,
                        validator: emailValidator),
                    feild(
                        label: "Phone Number",
                        icondata: Icons.phone,
                        initialValue: userFormState.phoneNumber!,
                        onchanged: (value) {
                          userFormController.update(phoneNumber: value);
                        },
                        readOnly: isCurrentUser == true ? true : false,
                        validator: phoneNumberValidator),
                    //TODO
                    if (ref.read(authNotifierProvider)!.role == true)
                      SwitchListTile(
                          title: Text("Is Admin"),
                          value: userFormState.role ?? false,
                          //false,
                          onChanged: (value) {
                            userFormController.update(role: value);
                          })

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
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 80),
              //   child: customButton(
              //       onPressed: () {},
              //       iconData: Icons.delete,
              //       string: "Deactivate "),
              // )
            ],
          ),
        ],
      ),
    ));
  }

  Padding feild(
      {required String label,
      required IconData icondata,
      required String initialValue,
      required Function(String) onchanged,
      String? Function(String?)? validator,
      bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        readOnly: readOnly,
        onChanged: (value) {
          onchanged(value);
        },
        initialValue: initialValue,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: Icon(icondata),
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

  Padding customTextFormField({
    TextEditingController? textEditingController,
    required IconData iconData,
    required String text,
  }) {
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
