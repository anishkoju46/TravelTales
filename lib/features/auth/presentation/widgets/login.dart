import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final enteredUsername = _usernameController.text;
      final enteredPassword = _passwordController.text;

      if (enteredUsername == "Admin" && enteredPassword == "Admin") {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: const Text("TRAVEL APP"),
        // ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              image: const DecorationImage(
                colorFilter: ColorFilter.linearToSrgbGamma(),
                image: AssetImage(
                  'assets/images/hat.jpeg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              Text(
                'TravelTales',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 200.00, bottom: 10.00),
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange)),
                        // border: OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.black)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        labelText: 'User Name',
                        labelStyle:
                            TextStyle(color: Colors.orange, fontSize: 21),
                        hintText: 'Username or Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid Credentials";
                        } else if (value.length <= 3) {
                          return "User name should should be atleast 4 letters";
                        }

                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.00, right: 10.00, top: 30.00, bottom: 0.00),
                    child: TextFormField(
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 173, 166, 144)),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter valid Credentials";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'Password',
                        hintText: 'Enter Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 100.00,
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          _login(context);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.orange),
                        )),
                  ),
                ]),
              ),
            ]),
          ),
        ));
  }
}
