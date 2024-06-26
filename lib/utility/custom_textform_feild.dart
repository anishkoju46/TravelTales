import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild(
      {super.key,
      this.controller,
      required this.credentials,
      this.iconData,
      this.initialValue,
      this.onTapIcon,
      required this.onchanged,
      required this.validator,
      this.obscureText = false,
      this.readOnly = false});
  final IconData? iconData;
  final String credentials;
  final String? initialValue;
  final Function(String) onchanged;
  final bool obscureText;
  final bool? Function(bool)? onTapIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return form(context,
        credentials: credentials,
        onchanged: onchanged,
        controller: controller,
        iconData: iconData,
        initialValue: initialValue,
        onTapIcon: onTapIcon,
        obscureText: obscureText,
        validator: validator,
        readOnly: readOnly);
  }

  Padding form(BuildContext context,
      {IconData? iconData,
      required String credentials,
      String? initialValue,
      required Function(String) onchanged,
      bool obscureText = false,
      bool? Function(bool)? onTapIcon,
      TextEditingController? controller,
      String? Function(String?)? validator,
      bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: TextFormField(
        readOnly: readOnly,
        validator: validator,
        // maxLines: null,
        inputFormatters: [LengthLimitingTextInputFormatter(200)],
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
