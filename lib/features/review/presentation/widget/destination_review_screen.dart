import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/controller/review_form_controller.dart';
import 'package:traveltales/features/review/presentation/state/review_state.dart';
import 'package:traveltales/features/review/presentation/widget/review_box.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';

class DestinationReview extends ConsumerWidget {
  const DestinationReview({super.key, required this.destination, this.review});
  final DestinationModel destination;
  final ReviewModel? review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewFormController = ref.read(reviewFormProvider(review).notifier);
    final reviewList = ref.watch(reviewListProvider);
    int? rating = 0;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              child: reviewList.when(
                  data: (data) => data.isEmpty
                      ? Center(child: Text("There are no reviews"))
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ReviewBox(review: data[index]);
                          }),
                  error: ((error, stackTrace) => Center(
                        child: Text(error.toString()),
                      )),
                  loading: () => Center(
                        child: CircularProgressIndicator(),
                      ))),
          //For Rating Dialouge Box
          ratingBox(context, rating, reviewFormController),
          Row(
            children: [
              Expanded(
                child: CustomTextFormFeild(
                  credentials: "Write a review...",
                  onchanged: (value) {
                    reviewFormController.update(review: value);
                  },
                  iconData: Icons.notes,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertBox(
                              confirmText: "Post",
                              onPressed: () {
                                Navigator.pop(context);
                                reviewFormController.handleSubmit(context);
                              },
                              title: "Post Review?");
                        });
                  },
                  child: Text("Post"))
            ],
          )
        ],
      ),
    ));
  }

  ElevatedButton ratingBox(BuildContext context, int? rating,
      ReviewFormController reviewFormController) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Container(
                    alignment: Alignment.center,
                    child: Text("Rate Destination")),
                content: RatingBar.builder(
                    initialRating: rating!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (value) {
                      rating = value.toInt();
                      // update yeta hai
                      reviewFormController.update(rating: rating);
                    }),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Discard")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            reviewFormController.handleSubmit(context);
                          },
                          child: Text("Rate"))
                    ],
                  )
                ],
              );
            });
      },
      child: Text("Rate Destination"),
    );
  }

  // Future<void> showRatingDialog(
  //     BuildContext context, ReviewFormController reviewFormController) async {
  //   double rating = 0; // Initialize with default rating value

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Rate Destination"),
  //         content: RatingBar.builder(
  //           initialRating: rating,
  //           fillColor: Colors.amber,
  //           borderColor: Colors.amber,
  //           allowHalfRating: false,
  //           onRatingUpdate: (value) {
  //             rating = value;
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Discard"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // Pass the selected rating to your controller for further processing
  //               //reviewFormController.updateRating(rating.toInt());
  //             },
  //             child: Text("Rate"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // Future<void> showRatingDialog(BuildContext context, ReviewFormController reviewFormController) async {
  //   int? rating = 0; // Initialize with default rating value

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Rate Destination"),
  //         content: Ratingbar.builder(
  //           initialRating: rating,
  //           minRating: 1,
  //           direction: Axis.horizontal,
  //           allowHalfRating: false,
  //           itemCount: 5,
  //           itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
  //           itemBuilder: (context, _) => Icon(
  //             Icons.star,
  //             color: Colors.amber,
  //           ),
  //           onRatingUpdate: (value) {
  //             rating = value.toInt();
  //           },
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Discard"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // Pass the selected rating to your controller for further processing
  //               reviewFormController.updateRating(rating);
  //             },
  //             child: Text("Rate"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
