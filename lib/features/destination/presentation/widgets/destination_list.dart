import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_controller.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_list_controller.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';

class DestinationList extends ConsumerWidget {
  const DestinationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.read(destinationListProvider.notifier);
    final destinationList = ref.watch(destinationListProvider);
    print(destinationList.length);
    return ListView.builder(
        controller: scrollController.listScrollController,
        itemCount: destinationList.length,
        itemBuilder: (BuildContext context, int index) {
          return DestinationListItem(
              destination: destinationList[index],
              onPressed: () {
                ref
                    .read(destinationListProvider.notifier)
                    .showDestinationDetails(context, destinationList[index]);
              });
        });
  }
}
