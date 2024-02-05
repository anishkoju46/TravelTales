import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild(
      {super.key,
      this.controller,
      required this.credentials,
      this.iconData,
      this.initialValue,
      this.onTapIcon,
      required this.onchanged});
  final IconData? iconData;
  final String credentials;
  final String? initialValue;
  final Function(String) onchanged;
  final bool obscureText = false;
  final bool? Function(bool)? onTapIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return form(context,
        credentials: credentials,
        onchanged: onchanged,
        controller: controller,
        iconData: iconData,
        initialValue: initialValue,
        onTapIcon: onTapIcon,
        obscureText: obscureText);
  }

  Padding form(
    BuildContext context, {
    IconData? iconData,
    required String credentials,
    String? initialValue,
    required Function(String) onchanged,
    bool obscureText = false,
    bool? Function(bool)? onTapIcon,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
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
