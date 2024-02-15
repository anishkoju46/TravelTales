import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/map/presentation/widgets/map_screen_riverpod.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class DestinationDetailScreen extends ConsumerWidget {
  const DestinationDetailScreen({super.key, required this.destinationModel});
  final DestinationModel destinationModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: details(context, destinationModel: destinationModel),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        final destinationPin = LatLng(
                          Angle.degree(
                              destinationModel.coordinates!.coordinates!.last),
                          Angle.degree(
                              destinationModel.coordinates!.coordinates!.first),
                        );
                        return MapScreenNew(
                          pin: destinationPin,
                          controller: MapController(
                            location: LatLng(
                              Angle.degree(destinationModel
                                  .coordinates!.coordinates!.last),
                              Angle.degree(destinationModel
                                  .coordinates!.coordinates!.first),
                            ),
                          ),
                        );
                        // return MapScreen(
                        //     controller: MapController(
                        //   location: LatLng(
                        //       Angle.degree(destinationModel
                        //           .coordinates!.coordinates!.last),
                        //       Angle.degree(destinationModel
                        //           .coordinates!.coordinates!.first)),
                        //   // zoom: 3
                        // ));
                      },
                    ));
                  },
                  icon: Icon(Icons.explore_rounded),
                  label: Text("Directions"),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.blue,
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  infoMethod(context,
                      infoTitle: "Max Height",
                      information: destinationModel.maxHeight!,
                      icon: Icons.landscape),
                  infoMethod(context,
                      infoTitle: "Duration",
                      information: destinationModel.duration!,
                      icon: Icons.timelapse)
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                  // color: Colors.amber,
                  child: Column(
                children: [
                  infoMethod(context,
                      infoTitle: "Best Season",
                      information: destinationModel.bestSeason!,
                      icon: Icons.foggy),
                  infoMethod(context,
                      infoTitle: "Region",
                      information: destinationModel.region!,
                      icon: Icons.place)
                ],
              )),
            ),
            Expanded(
              child: Container(
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   padding: EdgeInsets.symmetric(vertical: 5),
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           Expanded(
      //             child: infoMethod(
      //               destinationModel: destinationModel,
      //               icon: Icons.landscape,
      //               infoTitle: "Max Height",
      //               information: destinationModel.maxHeight!,
      //             ),
      //           ),
      //           Expanded(
      //               child: infoMethod(
      //                   destinationModel: destinationModel,
      //                   infoTitle: "Best Season",
      //                   information: destinationModel.bestSeason!,
      //                   icon: Icons.foggy)),
      //         ],
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: infoMethod(
      //               destinationModel: destinationModel,
      //               icon: Icons.calendar_month,
      //               infoTitle: "Duration",
      //               information: destinationModel.duration!,
      //             ),
      //           ),
      //           Expanded(
      //               child: infoMethod(
      //                   destinationModel: destinationModel,
      //                   infoTitle: "Region",
      //                   information: destinationModel.region!,
      //                   icon: Icons.map)),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
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
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Emergency Contacts",
                style: Theme.of(context).textTheme.headlineSmall),
            Consumer(builder: (context, ref, child) {
              return FilledButton(
                  onPressed: () {
                    ref.read(destinationListProvider.notifier).emergencyContact(
                        destinationModel.emergencyContact!.first);
                  },
                  child: Text(destinationModel.emergencyContact!.first));
            })
          ],
        ),
      ),
    ]);
  }

  Container infoMethod(
    BuildContext context, {
    required String infoTitle,
    required String information,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                infoTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(information),
            ],
          )
        ],
      ),
    );
  }
}
