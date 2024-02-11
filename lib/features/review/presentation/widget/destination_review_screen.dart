import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/state/review_state.dart';
import 'package:traveltales/features/review/presentation/widget/review_box.dart';
import 'package:traveltales/utility/custom_textform_feild.dart';

class DestinationReview extends ConsumerWidget {
  const DestinationReview({super.key, required this.destination, this.review});
  final DestinationModel destination;
  final ReviewModel? review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewFormController = ref.read(reviewFormProvider(review).notifier);
    final reviewList = ref.watch(reviewListProvider);
    double? rating = 0;
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
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: FilledButton(
              onPressed: () {
                //bottom modalsheet
                showModalBottomSheet(
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: reviewFormController.formKey,
                            child: CustomTextFormFeild(
                                credentials: "Write a Review...",
                                onchanged: (value) {
                                  reviewFormController.update(review: value);
                                }),
                          ),
                          Column(
                            children: [
                              RatingBar.builder(
                                  updateOnDrag: true,
                                  initialRating: rating!.toDouble(),
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4),
                                  itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                      ),
                                  onRatingUpdate: (value) {
                                    rating = value;
                                    // update yeta hai
                                    reviewFormController.update(
                                        rating: rating,
                                        destination: destination);
                                  }),
                            ],
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    reviewFormController.handleSubmit(context);
                                  },
                                  child: Text("Submit"))),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Write a Review...  "),
                    Icon(Icons.notes),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
