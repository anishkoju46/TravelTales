import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupFormController = ref.read(userFormProvider(user).notifier);
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
                  style: Theme.of(context).textTheme.titleLarge,
                )),
            Form(
              key: signupFormController.formKey,
              child: Column(
                children: [
                  signUpCustomTextFormField(
                      iconData: Icons.person,
                      label: "FullName",
                      onchanged: (value) {
                        signupFormController.update(fullName: value);
                      }),
                  signUpCustomTextFormField(
                      iconData: Icons.mail,
                      label: "Email",
                      onchanged: (value) {
                        signupFormController.update(email: value);
                      }),
                  signUpCustomTextFormField(
                      iconData: Icons.phone,
                      label: "Phone Number",
                      onchanged: (value) {
                        signupFormController.update(phoneNumber: value);
                      }),
                  signUpCustomTextFormField(
                      iconData: Icons.lock,
                      label: "Password",
                      onchanged: (value) {}),
                  signUpCustomTextFormField(
                      iconData: Icons.lock,
                      label: "Confirm Password",
                      onchanged: (value) {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  signupFormController.handleSubmit(context);
                },
                child: Text("SIGN UP"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
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

  Padding signUpCustomTextFormField(
      {required String label,
      required IconData iconData,
      required Function(String) onchanged,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        onChanged: (value) {
          onchanged(value);
        },
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
