import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/destination/presentation/widgets/destination_detail_screen.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';
import 'package:traveltales/features/review/presentation/widget/destination_review_screen.dart';
import 'package:traveltales/utility/arrowBackWidget.dart';
import 'package:traveltales/utility/customImageViewer.dart';
import 'package:traveltales/utility/smooth_Page_Indicator.dart';

final activeImageIndexProvider = StateProvider<int>((ref) => 0);

class DestinationDashboard extends ConsumerWidget {
  DestinationDashboard({super.key, required this.destinationModel});
  final DestinationModel destinationModel;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final navigationIndex = ref.read(activeImageIndexProvider.notifier);
    int currentIndex = ref.watch(activeImageIndexProvider);
    print("First Wala ${currentIndex}");
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
                  child: destinationModel.imageUrl?.length == 0
                      ? Image.asset(
                          "assets/travelPic/temp.jpeg",
                          fit: BoxFit.cover,
                        )
                      : PageView.builder(
                          controller: pageController,
                          itemCount: destinationModel.imageUrl?.length,
                          onPageChanged: (index) {
                            currentIndex = index;
                            print("Second Wala ${currentIndex}");
                            ref.read(activeImageIndexProvider.notifier).state =
                                currentIndex;
                          },
                          itemBuilder: (context, index) {
                            final assetImage = Image.asset(
                              "assets/travelPic/temp.jpeg",
                              fit: BoxFit.cover,
                            );
                            if (destinationModel.imageUrl != null &&
                                index < destinationModel.imageUrl!.length) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CustomImageViewer(
                                            url: ref
                                                .read(destinationListProvider
                                                    .notifier)
                                                .parseImage(
                                                    path: destinationModel
                                                        .imageUrl![index]),
                                            index: index,
                                          )));
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: ref
                                      .read(destinationListProvider.notifier)
                                      .parseImage(
                                          path: destinationModel
                                              .imageUrl![index]),
                                  placeholder: (context, url) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      assetImage,
                                ),
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
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: Consumer(builder: (context, ref, child) {
                    return MyCustomSmoothPageIndicator(
                      pageController: pageController,
                      count: destinationModel.imageUrl!.length,
                      activeColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      // inActiveColor: Theme.of(context).colorScheme.primary,
                      pageScrollDuration: const Duration(milliseconds: 200),
                    );
                  }),
                )

                // Positioned(
                //   bottom: 10,
                //   left: MediaQuery.of(context).size.width / 2 - 30,
                //   child: Consumer(builder: (context, ref, child) {
                //      final activeIndex = ref.watch(activeImageIndexProvider.notifier).state;
                //     return SmoothPageIndicator(
                //       controller: pageController,
                //       count: destinationModel.imageUrl!.length,
                //       effect: const WormEffect(
                //           dotColor: Colors.white,
                //           dotWidth: 15,
                //           dotHeight: 7,
                //           activeDotColor: Colors.amber),
                //       onDotClicked: (index) {
                //         pageController.animateToPage(index,
                //             duration: const Duration(milliseconds: 300),
                //             curve: Curves.linear);
                //       },
                //     );
                //   }),
                // )
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
