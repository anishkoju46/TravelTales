import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/dashboard/user_dashboard/presentation/user_dashboard_model.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_controller.dart';

class DestinationDetailScreen extends ConsumerWidget {
  const DestinationDetailScreen({super.key, required this.destinationModel});
  final DestinationModel destinationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return UserDashboard();
              //     },
              //   ),
              // );
            },
            icon: Icon(Icons.star),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(destinationModel.imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(child: details(destinationModel: destinationModel)),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(22),
                ),
              ),
              child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.explore),
                  label: Text("Directions")))
        ],
      ),
    ));
  }

  Container details({required DestinationModel destinationModel}) {
    return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(destinationModel.name),
              Text(destinationModel.maxHeight)
            ],
          ),
          Text(destinationModel.description),
          Text(destinationModel.bestSeason),
          Text(destinationModel.region),
          Text(destinationModel.itinerary)
        ]));
  }
}
