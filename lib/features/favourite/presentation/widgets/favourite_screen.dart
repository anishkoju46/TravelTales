import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_list.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //For Tile Travel Tales
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Favourite",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
                //Search bar
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: SearchBar(
                //     onTap: () {},
                //     leading: Icon(Icons.search),
                //     hintText: "Search for a place",
                //   ),
                // ),
                //Title: Category
                // Container(
                //   alignment: Alignment.topLeft,
                //   child: Text(
                //     "Categories",
                //     style: Theme.of(context)
                //         .textTheme
                //         .headlineSmall
                //         ?.copyWith(fontWeight: FontWeight.w500),
                //   ),
                // ),
                // Category Navigator Bar
              ],
            ),
          ),
          Expanded(child: FavouriteList())
        ],
      ),
    );
  }
}
