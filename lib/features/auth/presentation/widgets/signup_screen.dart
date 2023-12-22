import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              alignment: Alignment.topLeft,
              child: Text(
                "Ready to Explore\nReal Nepal?",
                style: Theme.of(context).textTheme.titleLarge,
              )),
          Column(
            children: [
              signUpCustomTextFormField(
                  iconData: Icons.person, credentials: "FullName"),
              signUpCustomTextFormField(
                  iconData: Icons.mail, credentials: "Email"),
              signUpCustomTextFormField(
                  iconData: Icons.phone, credentials: "Phone Number"),
              signUpCustomTextFormField(
                  iconData: Icons.lock, credentials: "Password"),
              signUpCustomTextFormField(
                  iconData: Icons.lock, credentials: "Confirm Password")
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
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
    ));
  }

  Padding signUpCustomTextFormField(
      {TextEditingController? textEditingController,
      required IconData iconData,
      required String credentials}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          labelText: credentials,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
