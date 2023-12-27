import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_list_controller.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';

class FavouriteList extends ConsumerWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final scrollController = ref.read(favouriteProvider.notifier);
    final favouriteList = ref.watch(favouriteProvider).entries.toList();
    return ListView.builder(
        // controller: scrollController.listScrollController,
        itemCount: favouriteList.length,
        itemBuilder: (BuildContext context, int index) {
          return DestinationListItem(
              destination: favouriteList[index].value,
              onPressed: () {
                ref
                    .read(destinationListProvider.notifier)
                    .showDestinationDetails(
                        context, favouriteList[index].value);
              });
        });
  }
}
