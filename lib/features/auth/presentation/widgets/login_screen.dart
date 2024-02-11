import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/auth/presentation/widgets/signup_screen.dart';

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
                        customTextFormField(
                          controller: loginController.emailController,
                          credentials: "Email",
                          iconData: Icons.email,
                          onchanged: (value) {
                            loginController.update(email: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email address";
                            } else if (!value.endsWith('@gmail.com')) {
                              return "Invalid Email";
                            }
                            return null;
                          },

                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter an email';
                          //   } else if (!RegExp(
                          //           r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          //       .hasMatch(value)) {
                          //     return 'Invalid Email';
                          //   }
                          //   return null;
                          // },
                        ),
                        customTextFormField(
                          controller: loginController.passwordController,
                          obscureText: loginFormState.showPassword,
                          // initialValue: loginFormState.password,
                          iconData: loginFormState.showPassword
                              ? Icons.lock
                              : Icons.lock_open,
                          onTapIcon: (value) {
                            return loginController.update(showPassword: value);
                          },
                          credentials: "Password",
                          onchanged: (value) {
                            loginController.update(password: value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            } else if (value.length < 8 || value.length > 11) {
                              return "Invalid Credential";
                            } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[!@#$])')
                                .hasMatch(value)) {
                              return "Invalid Credential";
                            } else {
                              return null;
                            }
                          },
                        ),
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
                      ],
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
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
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

  Padding customTextFormField(
      {required IconData iconData,
      required String credentials,
      String? initialValue,
      required Function(String) onchanged,
      bool obscureText = false,
      bool? Function(bool)? onTapIcon,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        onChanged: (data) {
          onchanged(data);
        },
        initialValue: initialValue,
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: onTapIcon != null
                ? () {
                    onTapIcon(!obscureText);
                  }
                : null,
            child: Icon(iconData),
          ),
          labelText: credentials,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
