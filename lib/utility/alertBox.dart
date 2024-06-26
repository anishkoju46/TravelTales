import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlertBox extends ConsumerWidget {
  const AlertBox({
    super.key,
    required this.confirmText,
    required this.onPressed,
    required this.title,
    // this.image
  });
  final Function onPressed;
  final String title;
  final String confirmText;
  // final File? image;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return newMethod(context, ref,
        confirmText: confirmText, onPressed: onPressed, title: title);
  }

  AlertDialog newMethod(BuildContext context, WidgetRef ref,
      {required String title,
      required String confirmText,
      required Function onPressed}) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text(
          textAlign: TextAlign.center,
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary),
        ),
      ),
      // content: Container(
      //   height: 100,
      //   width: 100,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: FileImage(image!), // Use FileImage for File
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      //content: Text("Do you want to delete"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Discard"),
            ),
            ElevatedButton(
              onPressed: () {
                onPressed();
                //Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(confirmText),
            ),
          ],
        ),
      ],
    );
  }
}
