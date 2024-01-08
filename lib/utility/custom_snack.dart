import 'package:flutter/material.dart';

class CustomSnack {
  static success(BuildContext context, {String message = "Successfull"}) {
    _showSnackBar(context, message: message, bgColor: Colors.green);
  }

  static error(BuildContext context, {String message = "Failed"}) {
    _showSnackBar(context, message: message, bgColor: Colors.red);
  }

  static info(BuildContext context, {String message = "Alert"}) {
    _showSnackBar(context, message: message, bgColor: Colors.blueGrey);
  }

  static _showSnackBar(BuildContext context,
      {String message = "", Color? bgColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: bgColor,
    ));
  }
}
