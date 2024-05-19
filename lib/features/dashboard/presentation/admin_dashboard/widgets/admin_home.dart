import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Controller/user_search_delegate.dart';
import 'package:traveltales/features/category/presentation/widgets/category_list.dart';
import 'package:traveltales/features/dashboard/controller/user_home_controller.dart';
import 'package:traveltales/features/dashboard/state/user_home_state.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        return ref.read(userHomeProvider.notifier).refresh();
      },
      child: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ADMIN",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(destinationListProvider.notifier)
                                  .showForm(context);
                            },
                            icon: Icon(
                              Icons.add_link,
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                            ),
                          )
                        ],
                      ),
                    ),
                    //Search bar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: SearchBar(
                        onTap: () {
                          showSearch(
                              context: context, delegate: UserSearchDelegate());
                        },
                        leading: Icon(Icons.search),
                        hintText: "Search for a place",
                      ),
                    ),
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
                    Container(
                        //color: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: SizedBox(height: 38, child: CategoryList())),
                  ],
                ),
              ),
              //END OF TITLE AND SEARCH
            ],
          ),
          Expanded(child: DestinationList()),
        ],
      ),
    );
  }
}
