import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_controller.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';

class DestinationList extends ConsumerWidget {
  const DestinationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.read(destinationProvider.notifier);
    final destinationList = ref.watch(destinationProvider);
    return ListView.builder(
        controller: scrollController.listScrollController,
        itemCount: destinationList.length,
        itemBuilder: (BuildContext context, int index) {
          return DestinationListItem(
              destination: destinationList[index],
              onPressed: () {
                ref
                    .read(destinationProvider.notifier)
                    .showDestinationDetails(context, destinationList[index]);
              });
        });
  }
}
