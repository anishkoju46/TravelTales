import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/auth/presentation/widgets/signup_screen.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/theme_controller.dart';
import 'package:traveltales/utility/validator.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginFormState = ref.watch(loginNotifierProvider);
    //final currentUserController = ref.read(authNotifierProvider.notifier);
    final loginController = ref.read(loginNotifierProvider.notifier);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/TT.png"))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Form(
                    key: loginController.formKey,
                    child: Column(
                      children: [
                        CustomTextFormFeild(
                            controller: loginController.emailController,
                            credentials: "Email",
                            iconData: Icons.email,
                            onchanged: (value) {
                              loginController.update(email: value);
                            },
                            validator: emailValidator),
                        CustomTextFormFeild(
                            controller: loginController.passwordController,
                            obscureText: loginFormState.showPassword,
                            // initialValue: loginFormState.password,
                            iconData: loginFormState.showPassword
                                ? Icons.lock
                                : Icons.lock_open,
                            onTapIcon: (value) {
                              return loginController.update(
                                  showPassword: value);
                            },
                            credentials: "Password",
                            onchanged: (value) {
                              loginController.update(password: value);
                            },
                            validator: passwordValidator),
                        ElevatedButton(
                          onPressed: () {
                            if (loginController.formKey.currentState
                                    ?.validate() ??
                                false) {
                              loginController.login(context);
                            }
                          },
                          child: Text('LOGIN'),
                        )
                      ]
                          .map((e) => Container(
                                child: e,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignupScreen();
                }));
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "dont have an account?",
                      style: context.theme.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " Sign Up",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.tertiaryContainer),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  // Padding customTextFormField(
  //     {required IconData iconData,
  //     required String credentials,
  //     String? initialValue,
  //     required Function(String) onchanged,
  //     bool obscureText = false,
  //     bool? Function(bool)? onTapIcon,
  //     TextEditingController? controller,
  //     String? Function(String?)? validator}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
  //     child: TextFormField(
  //       validator: validator,
  //       controller: controller,
  //       obscureText: obscureText,
  //       onChanged: (data) {
  //         onchanged(data);
  //       },
  //       initialValue: initialValue,
  //       decoration: InputDecoration(
  //         suffixIcon: InkWell(
  //           onTap: onTapIcon != null
  //               ? () {
  //                   onTapIcon(!obscureText);
  //                 }
  //               : null,
  //           child: Icon(iconData),
  //         ),
  //         labelText: credentials,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(25),
  //           borderSide: BorderSide(color: Colors.red),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
