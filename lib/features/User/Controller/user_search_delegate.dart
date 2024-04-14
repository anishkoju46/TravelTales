import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list_item.dart';
import 'package:traveltales/utility/ref_extension.dart';

class UserSearchDelegate extends SearchDelegate {
  String oldQuery = "";
  late final searchProvider =
      FutureProvider<List<DestinationModel>?>((ref) async {
    if (query.isEmpty) {
      return null;
    }
    final client = await ref.handleDebounceAndCancel();
    final destination = await DestinationRepository(
            token: ref.watch(authNotifierProvider)?.token)
        .search(client: client, query: query);
    return destination;
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    //app bar ko actions haru right side ma
    return [
      Consumer(builder: (context, ref, child) {
        return IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            oldQuery = '';
            ref.invalidate(searchProvider);
            // When pressed here the query will be cleared from the search bar.
          },
        );
      }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //appbar backbutton
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    //search garesi ako resuts haru
    // print(query);
    // return Text("Delegate");
    return searchResults();
  }

  Widget searchResults() {
    return Consumer(builder: (context, ref, child) {
      if (query.isNotEmpty) {
        if (query != oldQuery) {
          oldQuery = query;
          ref.invalidate(searchProvider);
        }
        final searchAsync = ref.watch(searchProvider);
        return searchAsync.when(
            data: (data) => data == null
                ? Container()
                : data.isEmpty
                    ? Text("Not Found Related to $query")
                    : ListView.builder(
                        // key: UniqueKey(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return DestinationListItem(
                              destination: data[index],
                              onPressed: () {
                                ref
                                    .read(destinationListProvider.notifier)
                                    .showDestinationDetails(
                                        context, data[index]);
                              });
                        },
                      ),
            error: ((error, stackTrace) => Center(
                  child: Text(error.toString()),
                )),
            loading: () => Center(
                  child: CircularProgressIndicator(),
                ));
      } else {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage("assets/images/Hiking_pana.png"))),
          child: Text(
            "Type to Search, eg: langtang...",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700),
          ),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //search garnu agadi lekhnu or tip for users
    // return Text("Delegate");
    // print(query);
    //   if (query.isEmpty) {
    //     return ListView.builder(
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Text("sdf"),
    //           leading: Icon(Icons.abc),
    //           trailing: Icon(Icons.close),
    //         );
    //       },
    //     );
    //   } else {
    //     showResults(context);
    //     return Container();
    //   }
    return searchResults();
  }
}


// return FutureBuilder(
      //   future:
      //       DestinationRepository(token: ref.watch(authNotifierProvider)?.token)
      //           .searchDestination(query: query),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(
      //           child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(Icons.search),
      //           Text("Not Found"),
      //         ],
      //       ));
      //     }
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //           //controller: scrollController.listScrollController,
      //           itemCount: snapshot.data!.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             return DestinationListItem(
      //                 destination: snapshot.data![index],
      //                 onPressed: () {
      //                   ref
      //                       .read(destinationListProvider.notifier)
      //                       .showDestinationDetails(
      //                           context, snapshot.data![index]);
      //                 });
      //           });
      //       // ListView.builder(
      //       //   itemCount: snapshot.data!.length,
      //       //   itemBuilder: (context, index) {
      //       //     return ListTile(
      //       //       title: Text(snapshot.data![index].name!),
      //       //       subtitle: Text(snapshot.data![index].category!.name!),
      //       //     );
      //       //   },
      //       // );
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   },
      // );