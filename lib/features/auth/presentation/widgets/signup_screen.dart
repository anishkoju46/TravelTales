import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

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
                  signUpCustomTextFormField(
                    iconData: Icons.person,
                    label: "FullName",
                    onchanged: (value) {
                      signUpFormController.update(fullName: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your FullName";
                      } else if (value.length >= 30) {
                        return "Please enter your name again";
                      } else {
                        return null;
                      }
                    },
                  ),
                  signUpCustomTextFormField(
                    iconData: Icons.mail,
                    label: "Email",
                    onchanged: (value) {
                      signUpFormController.update(email: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email address";
                      } else if (!value.endsWith('@gmail.com')) {
                        return "Please enter a valid Gmail address";
                      }
                      return null;
                    },
                  ),
                  signUpCustomTextFormField(
                    iconData: Icons.phone,
                    label: "Phone Number",
                    onchanged: (value) {
                      signUpFormController.update(phoneNumber: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a phone number";
                      } else if (value.length != 10) {
                        return "Please enter a valid phone number";
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Phone number should only have numeric characters";
                      } else if (!value.startsWith("98")) {
                        return "Phone number must start with '98'";
                      } else
                        return null;
                    },
                  ),
                  signUpCustomTextFormField(
                    obscureText: signUpFormState.showPassword,
                    iconData: signUpFormState.showPassword
                        ? Icons.lock
                        : Icons.lock_open,
                    onTapIcon: (value) {
                      return signUpFormController.update(showPassword: value);
                    },
                    label: "Password",
                    onchanged: (value) {
                      signUpFormController.update(password: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 8 || value.length > 11) {
                        return "Try again";
                      } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[!@#$])')
                          .hasMatch(value)) {
                        return "Must contatin a capital letter and one charecters: !, @, #, \$";
                      } else {
                        return null;
                      }
                    },
                  ),
                  signUpCustomTextFormField(
                    obscureText: signUpFormState.showConfirmPassword,
                    iconData: signUpFormState.showConfirmPassword
                        ? Icons.lock
                        : Icons.lock_open,
                    onTapIcon: (value) {
                      return signUpFormController.update(
                          showConfirmPassword: value);
                    },
                    label: "Confirm Password",
                    onchanged: (value) {
                      signUpFormController.update(confirmPassword: value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a password";
                      } else if (value.length < 8 || value.length > 11) {
                        return "Try again";
                      } else if (!RegExp(r'^(?=.*[A-Z])(?=.*[!@#$])')
                          .hasMatch(value)) {
                        return "Must contatin a capital letter and one charecters: !, @, #, \$";
                      } else {
                        return null;
                      }
                    },
                  )
                ],
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
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
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

  Padding signUpCustomTextFormField({
    required String label,
    required IconData iconData,
    required Function(String) onchanged,
    String? Function(String?)? validator,
    bool obscureText = false,
    bool? Function(bool)? onTapIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        obscureText: obscureText,
        onChanged: (value) {
          onchanged(value);
        },
        validator: validator,
        decoration: InputDecoration(
          //hoverColor: Colors.red,
          labelText: label,
          suffixIcon: InkWell(
            onTap: onTapIcon != null
                ? () {
                    onTapIcon(!obscureText);
                  }
                : null,
            child: Icon(iconData),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
