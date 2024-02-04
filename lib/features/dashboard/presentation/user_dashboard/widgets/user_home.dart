import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/presentation/widgets/category_list.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list.dart';

class UserHome extends ConsumerWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    onTap: () {},
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
                    //color: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: SizedBox(height: 30, child: CategoryList())),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Container(
                //     margin: EdgeInsets.symmetric(vertical: 10),
                //     padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(25),
                //       ),
                //       color: Theme.of(context).colorScheme.onBackground,
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         customCategoryBar(context, categoryOption: "Easy"),
                //         customCategoryBar(context, categoryOption: "Moderate"),
                //         customCategoryBar(context,
                //             categoryOption: "Challenging")
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 150,
                //   child: ListView.separated(
                //       itemBuilder: (context, index) {
                //         return SizedBox();
                //       },
                //       separatorBuilder: (BuildContext context, int index) {
                //         return SizedBox(
                //           height: 20,
                //         );
                //       },
                //       itemCount: 2),
                // )
              ],
            ),
          ),
          Expanded(child: DestinationList())
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(children: [
          //       destinationShowCase(context,
          //           image: "assets/langtang/langtang11.png",
          //           destination: "Langtang"),
          //       destinationShowCase(context,
          //           image: "assets/langtang/langtang11.png",
          //           destination: "Poon Hill"),
          //       destinationShowCase(context,
          //           image: "assets/langtang/langtang11.png",
          //           destination: "Ramechap"),
          //       destinationShowCase(context,
          //           image: "assets//langtang11.png",
          //           destination: "Mama Ghar"),
          //       destinationShowCase(context,
          //           image: "assets/langtang/langtang11.png",
          //           destination: "Uta"),
          //     ]),
          //   ),
          // )
        ],
      ),
    );
  }
}
