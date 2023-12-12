import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/auth/presentation/controller/login_controller.dart';
import 'package:traveltales/nothing/dashboard.dart';

//auth ma model
//usermodel type ko provider

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController =
      TextEditingController(text: "four@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "1111");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserController = ref.read(authNotifierProvider.notifier);
    final loginController = ref.read(loginNotifierProvider.notifier);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F9F4),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Text(
                            "Demo",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          customTextFormField(_emailController),
                          customTextFormField(_passwordController),
                          ElevatedButton(
                              onPressed: () {
                                loginController.login(context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              },
                              child: Text('LOGIN'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField customTextFormField(
      TextEditingController? textEditingController) {
    return TextFormField(
      controller: textEditingController,
    );
  }
}
