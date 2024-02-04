import 'package:flutter/material.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_detail_screen.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_review_screen.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';

class DestinationDashboard extends StatelessWidget {
  const DestinationDashboard({super.key, required this.destinationModel});
  final DestinationModel destinationModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage(destinationModel.imageUrl!.first), //TODO
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
            Container(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Color(0xffD9D9D9),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.center,
                  dividerColor: Colors.transparent,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 60),
                  isScrollable: true,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.primary),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Details",
                    ),
                    Tab(
                      text: "Reviews",
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: TabBarView(
                  children: [
                    DestinationDetailScreen(destinationModel: destinationModel),
                    DestinationReview(
                      destination: destinationModel,
                    )
                  ],
                ),
              ),
            )
          ],
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
}
