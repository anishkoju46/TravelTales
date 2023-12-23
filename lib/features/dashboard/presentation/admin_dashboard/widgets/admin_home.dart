import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_form.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
            child: Column(
          children: [],
        )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //YETA PASS GARNA PARXA HAI
                return DestinationForm();
              }));
            },
            child: Icon(
              Icons.add_link,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        )
      ],
    );
  }
}
