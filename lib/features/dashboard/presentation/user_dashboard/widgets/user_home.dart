import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Controller/user_search_delegate.dart';
import 'package:traveltales/features/category/presentation/widgets/category_list.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list.dart';

class UserHome extends ConsumerWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
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
                    child: SizedBox(height: 30, child: CategoryList())),
              ],
            ),
          ),
          Expanded(child: DestinationList())
        ],
      ),
    );
  }
}
