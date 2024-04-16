import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/state/emergency_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_list_tile.dart';
import 'package:traveltales/utility/theme_controller.dart';

class HotlineNumberItem extends ConsumerWidget {
  const HotlineNumberItem({super.key, required this.hotlineNumber});
  final HotlineNumbersModel hotlineNumber;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        return hotlineContainer(context,
            organizationName: hotlineNumber.organizationName!,
            phoneNumber: hotlineNumber.phoneNumber.toString(), onTap: () {
          ref
              .read(destinationListProvider.notifier)
              .emergencyContact(hotlineNumber.phoneNumber!);
        }, hotlineNumber: hotlineNumber);
      },
    );
  }

  Widget hotlineContainer(
    BuildContext context, {
    required String organizationName,
    required String phoneNumber,
    required Function onTap,
    required HotlineNumbersModel hotlineNumber,
  }) {
    return Consumer(builder: (context, ref, child) {
      final currentUser = ref.watch(authNotifierProvider);
      final isAdmin = currentUser?.role == true;
      return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.phone,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          organizationName,
                          style: context.theme.textTheme.titleMedium,
                        ),
                        Text(phoneNumber),
                      ],
                    ),
                  ),

                  //Edit and delte button for Admin
                  if (isAdmin)
                    Consumer(builder: (context, ref, child) {
                      return Container(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(hotlineListProvider.notifier)
                                    .showForm(context, model: hotlineNumber);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertBox(
                                        confirmText: "Confirm",
                                        onPressed: () {
                                          ref
                                              .read(
                                                  hotlineListProvider.notifier)
                                              .deleteHotlineNumber(
                                                  context, hotlineNumber);
                                          ref.refresh(hotlineListProvider);
                                          Navigator.of(context).pop();
                                        },
                                        title: "Delete Contact");
                                  },
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    })
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
