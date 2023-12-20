import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/login_controller.dart';
import 'package:traveltales/features/auth/presentation/widgets/signup_screen.dart';

//auth ma model
//usermodel type ko provider

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController =
      TextEditingController(text: "four@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "4444");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final currentUserController = ref.read(authNotifierProvider.notifier);
    final loginController = ref.read(loginNotifierProvider.notifier);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Travel Tales",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Logo.jpeg"))),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        customTextFormField(
                          textEditingController: _emailController,
                          credentials: "Email",
                          iconData: Icons.email,
                        ),
                        customTextFormField(
                            textEditingController: _passwordController,
                            credentials: "Password",
                            iconData: Icons.lock),
                        ElevatedButton(
                          onPressed: () {
                            loginController.login(context,
                                email: _emailController.text,
                                password: _passwordController.text);
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
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
      {TextEditingController? textEditingController,
      required IconData iconData,
      required String credentials}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
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
