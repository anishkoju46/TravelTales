import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';

class DestinationList extends ConsumerWidget {
  const DestinationList({super.key, this.searchResult});
  final AsyncValue<List<DestinationModel>>? searchResult;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final scrollController = ref.read(destinationListProvider.notifier);
    final destinationList = searchResult ?? ref.watch(destinationListProvider);

    return destinationList!.when(
        data: (data) => data.isEmpty
            ? Center(
                child: Text("No Destination Available"),
              )
            : ListView.builder(
                //controller: scrollController.listScrollController,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return DestinationListItem(
                      destination: data[index],
                      onPressed: () {
                        ref
                            .read(destinationListProvider.notifier)
                            .showDestinationDetails(context, data[index]);
                      });
                }),
        error: ((error, stackTrace) => Center(
              child: Text(error.toString()),
            )),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }
}
