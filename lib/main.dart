import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:traveltales/login.dart';
import 'package:traveltales/viewLocation.dart';

main() async {
  await GetStorage.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(useMaterial3: true),
    initialRoute: '/login',
    routes: {
      '/login': (context) => const LoginPage(),
      '/home': (context) => const ViewLocation(),
      //'/addLocation': (context) => const AddLocation(),
    },
  ));
}
