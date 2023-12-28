import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              //YETA PASS GARNA PARXA HAI
                              return DestinationForm();
                            }));
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
