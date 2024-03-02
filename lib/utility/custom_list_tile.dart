import 'package:flutter/material.dart';

Container customListTile(BuildContext context,
    {required IconData leadingIcon,
    required String title,
    required Function onTap,
    String? subtitle,
    Color? color,
    Color? borderColor,
    Color? TextColor}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: Theme.of(context).colorScheme.primaryContainer,
        color: color ?? Theme.of(context).colorScheme.onBackground,
        border: borderColor != null ? Border.all(color: borderColor) : null),
    child: ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
        leadingIcon,
        color: TextColor ?? Theme.of(context).colorScheme.onPrimary,
      ),
      title: Text(title,
          style: TextStyle(
              color: TextColor ?? Theme.of(context).colorScheme.background)
          // Theme.of(context).textTheme.titleLarge?.copyWith(
          //       fontWeight: FontWeight.w500,
          //     ),
          ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                  color: TextColor ?? Theme.of(context).colorScheme.background),
            )
          : null,
    ),
  );
}
