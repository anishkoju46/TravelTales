import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Controller/user_search_delegate.dart';
import 'package:traveltales/features/category/presentation/widgets/category_list.dart';
import 'package:traveltales/features/dashboard/controller/user_home_controller.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list.dart';

class UserHome extends ConsumerWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();

    final destinationController = ref.read(destinationListProvider.notifier);

    // final debouncer = Debouncer(Duration(milliseconds: 500));

    //  Timer? debounceTimer;

    // void onSearchChanged(String value) {
    //   if (debounceTimer != null) {
    //     debounceTimer!.cancel();
    //   }
    //   debounceTimer = Timer(Duration(microseconds: 500), () async {
    //     await destinationController.searchDestination(context, query: value);
    //   });
    // }

    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: RefreshIndicator(
        onRefresh: () async {
          return UserHomeController().refresh();
          // await ref.refresh(destinationListProvider);
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  //For Tile Travel Tales
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Travel Tales",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ),
                  //Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SearchBar(
                      controller: searchController,
                      //onChanged: onSearchChanged,
                      onTap: () {
                        showSearch(
                            context: context, delegate: UserSearchDelegate());
                      },
                      // onChanged: (value) async {
                      //   if (value.isNotEmpty) {
                      //     await destinationController.searchDestination(context,
                      //         query: value);
                      //   }
                      // },
                      leading: Icon(Icons.search),
                      hintText: "Search for a place",
                    ),
                  ),
                  //Title: Category
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Categories",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  // Category Navigator Bar
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(height: 38, child: CategoryList())),
                ],
              ),
            ),
            Expanded(child: DestinationList())
            // Expanded(
            //     child: searchController.text.isEmpty
            //         ? DestinationList()
            //         : DestinationList(
            //             searchResult: destinationController.searchDestination(
            //                 context,
            //                 query: searchController.text),
            //           ))
          ],
        ),
      ),
    );
  }
}
