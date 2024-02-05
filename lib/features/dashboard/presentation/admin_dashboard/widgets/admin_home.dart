import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/presentation/widgets/category_list.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_list.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
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
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   //YETA PASS GARNA PARXA HAI to EDIT destination
                            //   return AddDestinationForm();
                            // }));
                          },
                          icon: Icon(
                            Icons.add_link,
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),
                        )
                      ],
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
                  Container(
                      //color: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: SizedBox(height: 30, child: CategoryList())),
                ],
              ),
            ),
            //END OF TITLE AND SEARCH
          ],
        ),
        Expanded(child: DestinationList()),
      ],
    );
  }
}
