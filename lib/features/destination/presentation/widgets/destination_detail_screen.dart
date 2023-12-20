import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';

class DestinationDetailScreen extends ConsumerWidget {
  const DestinationDetailScreen({super.key, required this.destinationModel});
  final DestinationModel destinationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Stack(
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
              iconMethods(context, top: 7, left: 7, icon: Icons.arrow_back),
              Positioned(
                  right: 7,
                  top: 7,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: FavouriteButton(destination: destinationModel)))
            ],
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
              label: Text("Directions"),
            ),
          )
        ],
      ),
    ));
  }

  Positioned iconMethods(
    BuildContext context, {
    double? left,
    double? right,
    double? top,
    double? bottom,
    required IconData icon,
    Function? onTap,
  }) {
    return Positioned(
        top: top,
        left: left,
        bottom: bottom,
        right: right,
        child: InkWell(
          onTap: () {
            if (onTap == null) {
              Navigator.pop(context);
            } else {
              onTap();
            }
          },
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child:
                  Icon(icon, color: Theme.of(context).colorScheme.background)),
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
