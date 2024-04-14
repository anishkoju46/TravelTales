import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/state/emergency_state.dart';

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
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            "Add Hotline Numbers",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 25),
                ]),
            child: Column(
              children: [
                TextFormField(
                  initialValue: hotlineNumber?.organizationName,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text("Organization Name"),
                    ),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  onChanged: (value) {
                    HotlineNumberFormController.update(organizationName: value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: hotlineNumber?.phoneNumber,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Container(
                      margin: const EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text("Hotline Number"),
                    ),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  onChanged: (value) {
                    HotlineNumberFormController.update(numbers: value);
                  },
                ),
                IconButton(
                  onPressed: () {
                    HotlineNumberFormController.handleSubmit(context,
                        isAdd: isAdd);
                  },
                  icon: const Icon(
                    Icons.check_circle,
                    color: Color(0xff6fa8a4),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
