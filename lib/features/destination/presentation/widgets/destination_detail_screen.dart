import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class DestinationDetailScreen extends ConsumerWidget {
  const DestinationDetailScreen({super.key, required this.destinationModel});
  final DestinationModel destinationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              details(context, destinationModel: destinationModel),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.explore_rounded),
                  label: Text("Directions"),
                ),
              )
            ],
          ),
        ),
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
        child: ArrowBackWidget());
  }

  Column details(BuildContext context,
      {required DestinationModel destinationModel}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(destinationModel.name!,
          style: Theme.of(context).textTheme.displaySmall),
      Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: infoMethod(
                    destinationModel: destinationModel,
                    icon: Icons.landscape,
                    infoTitle: "Max Height",
                    information: destinationModel.maxHeight!,
                  ),
                ),
                Expanded(
                    child: infoMethod(
                        destinationModel: destinationModel,
                        infoTitle: "Best Season",
                        information: destinationModel.bestSeason!,
                        icon: Icons.foggy)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: infoMethod(
                    destinationModel: destinationModel,
                    icon: Icons.calendar_month,
                    infoTitle: "Duration",
                    information: destinationModel.duration!,
                  ),
                ),
                Expanded(
                    child: infoMethod(
                        destinationModel: destinationModel,
                        infoTitle: "Region",
                        information: destinationModel.region!,
                        icon: Icons.map)),
              ],
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description",
                style: Theme.of(context).textTheme.headlineSmall),
            Text(destinationModel.description!),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Itinerary", style: Theme.of(context).textTheme.headlineSmall),
            Text(destinationModel.itinerary!.first), //TODO
          ],
        ),
      ),
    ]);
  }

  Row infoMethod({
    required DestinationModel destinationModel,
    required String infoTitle,
    required String information,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        Column(
          children: [
            Text(infoTitle),
            Text(information),
          ],
        )
      ],
    );
  }
}


//  InkWell(
//           onTap: () {
//             if (onTap == null) {
//               Navigator.pop(context);
//             } else {
//               onTap();
//             }
//           },
//           child: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primary,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(12),
//                 ),
//               ),
//               child:
//                   Icon(icon, color: Theme.of(context).colorScheme.background)),
//         )