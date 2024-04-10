import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/data/respository/destination_repository.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_form_controller.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_detail_screen.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';
import 'package:traveltales/features/review/presentation/widget/destination_review_screen.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/smooth_Page_Indicator.dart';

class DestinationDashboard extends ConsumerWidget {
  DestinationDashboard({super.key, required this.destinationModel});
  final DestinationModel destinationModel;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  // decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image:
                  //         AssetImage(destinationModel.imageUrl!.first), //TODO
                  //     fit: BoxFit.cover),
                  // ),
                  child: destinationModel.imageUrl?.length == 0
                      ? Center(
                          child: Text("Add Images"),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destinationModel.imageUrl?.length,
                          itemBuilder: (context, index) {
                            final assetImage = Image.asset(
                              "assets/travelPic/temp.jpeg",
                              fit: BoxFit.cover,
                            );
                            if (destinationModel.imageUrl != null &&
                                index < destinationModel.imageUrl!.length) {
                              return CachedNetworkImage(
                                imageUrl: ref
                                    .read(destinationListProvider.notifier)
                                    .parseImage(
                                        path:
                                            destinationModel.imageUrl![index]),
                                placeholder: (context, url) {
                                  return assetImage;
                                },
                                errorWidget: (context, url, error) =>
                                    assetImage,
                              );
                            }
                            return assetImage;
                            // else??
                          },
                        ),
                ),
                iconMethods(context, top: 7, left: 7, icon: Icons.arrow_back),
                //Only show the add to favourite button if the user is normal user
                if (ref.read(authNotifierProvider)!.role == false)
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
                        child: FavouriteButton(destination: destinationModel)),
                  ),
                Positioned(
                    bottom: 10,
                    left: 200,
                    child: MyCustomSmoothPageIndicator(
                      pageController: pageController,
                      count: destinationModel.imageUrl!.length,
                      activeColor: const Color(
                          0xffCA8226), //colors chai theme ko use garnu paryo
                      inActiveColor: const Color(0xffFFCC5C),
                      pageScrollDuration: const Duration(milliseconds: 200),
                    ))
              ],
            ),
            Container(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
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
