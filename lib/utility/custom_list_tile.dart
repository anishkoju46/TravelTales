import 'package:flutter/material.dart';

Container customListTile(BuildContext context,
    {required IconData leadingIcon,
    required String title,
    required Function onTap,
    // Color? color,
    Color? color}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // color: Theme.of(context).colorScheme.primaryContainer,
        color: color ?? Theme.of(context).colorScheme.onBackground),
    child: ListTile(
      onTap: () {
        onTap();
      },
      leading: Icon(
        leadingIcon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      title: Text(title,
          style: TextStyle(color: Theme.of(context).colorScheme.background)
          // Theme.of(context).textTheme.titleLarge?.copyWith(
          //       fontWeight: FontWeight.w500,
          //     ),
          ),
    ),
  );
}
