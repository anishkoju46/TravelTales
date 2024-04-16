import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/theme_controller.dart';
import 'package:traveltales/utility/validator.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpFormState = ref.watch(signUpNotifierProvider);
    final signUpFormController = ref.read(signUpNotifierProvider.notifier);
    //final signupFormState = ref.watch(userFormProvider(user));
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  "Ready to Explore\nReal Nepal?",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                )),
            Form(
              key: signUpFormController.formKey,
              child: Column(
                children: [
                  CustomTextFormFeild(
                      iconData: Icons.person,
                      credentials: "FullName",
                      onchanged: (value) {
                        signUpFormController.update(fullName: value);
                      },
                      validator: fullNameValidator),
                  CustomTextFormFeild(
                      iconData: Icons.mail,
                      credentials: "Email",
                      onchanged: (value) {
                        signUpFormController.update(email: value);
                      },
                      validator: emailValidator),
                  CustomTextFormFeild(
                      iconData: Icons.phone,
                      credentials: "Phone Number",
                      onchanged: (value) {
                        signUpFormController.update(phoneNumber: value);
                      },
                      validator: phoneNumberValidator),
                  CustomTextFormFeild(
                      obscureText: signUpFormState.showPassword,
                      iconData: signUpFormState.showPassword
                          ? Icons.lock
                          : Icons.lock_open,
                      onTapIcon: (value) {
                        return signUpFormController.update(showPassword: value);
                      },
                      credentials: "Password",
                      onchanged: (value) {
                        signUpFormController.update(password: value);
                      },
                      validator: passwordValidator),
                  CustomTextFormFeild(
                      obscureText: signUpFormState.showConfirmPassword,
                      iconData: signUpFormState.showConfirmPassword
                          ? Icons.lock
                          : Icons.lock_open,
                      onTapIcon: (value) {
                        return signUpFormController.update(
                            showConfirmPassword: value);
                      },
                      credentials: "Confirm Password",
                      onchanged: (value) {
                        signUpFormController.update(confirmPassword: value);
                      },
                      validator: passwordValidator)
                ]
                    .map((e) => Container(
                          child: e,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  signUpFormController.signUp(context);
                },
                child: Text("SIGN UP"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "already have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: " Login",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.colorScheme.tertiaryContainer),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // Padding signUpCustomTextFormField({
  //   required String label,
  //   required IconData iconData,
  //   required Function(String) onchanged,
  //   String? Function(String?)? validator,
  //   bool obscureText = false,
  //   bool? Function(bool)? onTapIcon,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
  //     child: TextFormField(
  //       obscureText: obscureText,
  //       onChanged: (value) {
  //         onchanged(value);
  //       },
  //       validator: validator,
  //       decoration: InputDecoration(
  //         //hoverColor: Colors.red,
  //         labelText: label,
  //         suffixIcon: InkWell(
  //           onTap: onTapIcon != null
  //               ? () {
  //                   onTapIcon(!obscureText);
  //                 }
  //               : null,
  //           child: Icon(iconData),
  //         ),
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
