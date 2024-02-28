// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
// import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';
// import 'package:traveltales/features/search/presentation/state/search_state.dart';

// class SearchList extends ConsumerWidget {
//   const SearchList({super.key, required this.query});
//   final String query;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final searchList = ref
//         .watch(searchListProvider.notifier)
//         .searchDestination(context, query: query);

//     return searchList.when(
//         data: (data) => data.isEmpty
//             ? Center(
//                 child: Text("Searched Not Found"),
//               )
//             : ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return DestinationListItem(
//                       destination: data[index],
//                       onPressed: ref
//                           .read(destinationListProvider.notifier)
//                           .showDestinationDetails(context, data[index]));
//                 },
//               ),
//         error: ((error, stackTrace) => Center(
//               child: Text(error.toString()),
//             )),
//         loading: () => Center(
//               child: CircularProgressIndicator(),
//             ));
//   }
// }
