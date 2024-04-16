import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/state/emergency_state.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';
import 'package:traveltales/utility/validator.dart';

class HotlineNumberForm extends ConsumerWidget {
  const HotlineNumberForm({super.key, this.hotlineNumber});
  final HotlineNumbersModel? hotlineNumber;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAdd = hotlineNumber?.id == null;
    final hotlineFormProviders = hotlineFormProvider(hotlineNumber);
    final hotlineNumberFormState = ref.watch(hotlineFormProviders);
    final HotlineNumberFormController = ref.read(hotlineFormProviders.notifier);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: isAdd
            ? Text(
                "Add Emergency Contact",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              )
            : Text(
                "Edit Emergency Contact",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
      body: Column(
        children: [
          // Text(
          //   "Add Hotline Numbers",
          //   style: Theme.of(context)
          //       .textTheme
          //       .headlineMedium
          //       ?.copyWith(fontWeight: FontWeight.w500),
          // ),

          Form(
            key: HotlineNumberFormController.formKey,
            child: Column(
              children: [
                customTextFormField(
                    initialValue: hotlineNumber?.organizationName,
                    labelText: "Contact Name",
                    iconData: Icons.person,
                    onChanged: (value) {
                      HotlineNumberFormController.update(
                          organizationName: value);
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Contact name cannot be empty";
                      }

                      if (value.length >= 30) {
                        return "Please enter the name again";
                      }
                      return null;
                    }),
                customTextFormField(
                    initialValue: hotlineNumber?.phoneNumber,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    labelText: "Contact Number",
                    iconData: Icons.person,
                    onChanged: (value) {
                      HotlineNumberFormController.update(numbers: value);
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Contact number cannot be empty";
                      }

                      // Regular expression to validate phone number format
                      final phoneRegex = RegExp(
                        r'^98\d{8}$', // Assuming a 10-digit numeric wala phone number
                        caseSensitive: false,
                        multiLine: false,
                      );

                      // Check if the value matches the phone number format
                      if (!phoneRegex.hasMatch(value)) {
                        return "Invalid Contact number format";
                      }

                      // Return null if the phone number is valid
                      return null;
                    },
                    keyboardType: TextInputType.number),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (HotlineNumberFormController.formKey.currentState!
                  .validate()) {
                HotlineNumberFormController.handleSubmit(context, isAdd: isAdd);
                Navigator.pop(context);
              }
            },
            child: isAdd ? const Text("Add Contact") : Text("Edit Contact"),
          )

          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(10),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Colors.grey.withOpacity(0.3),
          //             spreadRadius: 5,
          //             blurRadius: 25),
          //       ]),
          //   child: Column(
          //     children: [
          //       TextFormField(
          //         initialValue: hotlineNumber?.organizationName,
          //         decoration: InputDecoration(
          //           floatingLabelBehavior: FloatingLabelBehavior.never,
          //           label: Container(
          //             margin: const EdgeInsets.only(left: 10),
          //             alignment: Alignment.centerLeft,
          //             child: const Text("Organization Name"),
          //           ),
          //           labelStyle: Theme.of(context)
          //               .textTheme
          //               .titleSmall
          //               ?.copyWith(color: Colors.grey.shade600),
          //         ),
          //         onChanged: (value) {
          //           HotlineNumberFormController.update(organizationName: value);
          //         },
          //       ),
          //       TextFormField(
          //         keyboardType: TextInputType.number,
          //         initialValue: hotlineNumber?.phoneNumber,
          //         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          //         decoration: InputDecoration(
          //           floatingLabelBehavior: FloatingLabelBehavior.never,
          //           label: Container(

          //             margin: const EdgeInsets.only(left: 10),
          //             alignment: Alignment.centerLeft,
          //             child: const Text("Hotline Number"),
          //           ),
          //           labelStyle: Theme.of(context)
          //               .textTheme
          //               .titleSmall
          //               ?.copyWith(color: Colors.grey.shade600),
          //         ),
          //         onChanged: (value) {
          //           HotlineNumberFormController.update(numbers: value);
          //         },
          //       ),
          //       IconButton(
          //         onPressed: () {
          //           HotlineNumberFormController.handleSubmit(context,
          //               isAdd: isAdd);
          //         },
          //         icon: const Icon(
          //           Icons.check_circle,
          //           color: Color(0xff6fa8a4),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    ));
  }

  Padding customTextFormField(
      {String? initialValue,
      IconData? iconData,
      required String labelText,
      required Function(dynamic) onChanged,
      String? Function(String?)? validator,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        maxLines: null,
        initialValue: initialValue,
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
          suffixIcon: Icon(iconData),
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
