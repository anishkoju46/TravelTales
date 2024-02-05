import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';

class AddDestinationScreen extends ConsumerWidget {
  const AddDestinationScreen({super.key, required this.destination});
  final DestinationModel destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinationFormController =
        ref.read(destinationFormProvider(destination));
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [],
      ),
    ));
  }

  TextFormField feild(
      {required String label,
      required String initialValue,
      required Function(String) onchanged,
      String? Function(String?)? validator}) {
    return TextFormField(
      onChanged: (value) {
        onchanged(value);
      },
      initialValue: initialValue,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
  }

  FilledButton customButton(
      {required Function onPressed,
      required IconData iconData,
      required String string}) {
    return FilledButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(iconData),
        label: Text(string));
  }
}
