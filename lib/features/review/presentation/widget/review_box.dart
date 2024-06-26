import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/review/data/repository/review_repository.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/state/review_state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_network_image.dart';

//eutaboxko code yesma
//reviewko model ni
class ReviewBox extends ConsumerWidget {
  const ReviewBox({
    super.key,
    required this.review,
  });
  final ReviewModel review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.primaryContainer),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //imageuserko
              Container(
                margin: const EdgeInsets.only(right: 10),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Consumer(builder: (context, ref, child) {
                    final baseUrl = UserRepository().baseUrl;
                    return CustomNetworkImage(
                        allowFullScreen: false,
                        url:
                            "$baseUrl${review.user?.imageUrl?.replaceAll('\\', '/')}");
                  }),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //User Email
                    Text(
                      "${review.user?.email}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    //Rating Bars
                    Container(
                      //color: Colors.red,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 3),
                            child: RatingBar.builder(
                                ignoreGestures: true,
                                allowHalfRating: true,
                                itemSize: 15,
                                initialRating: review.rating!.toDouble(),
                                itemCount: 5,
                                itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer,
                                    ),
                                onRatingUpdate: (value) {}),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            DateFormat.yMMMd().format(review.createdAt!),
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Text("${review.review}"),
                  ],
                ),
              ),
              if (ref.read(authNotifierProvider)!.role == true)
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertBox(
                              confirmText: "Delete",
                              onPressed: () async {
                                await ReviewRepository(
                                        token: ref
                                            .read(authNotifierProvider)
                                            ?.token)
                                    .deleteReview(review.id!);

                                ref.refresh(reviewListProvider);
                                Navigator.pop(context);
                              },
                              title: "Delete Review");
                        },
                      );
                    },
                    icon: Icon(Icons.delete))
            ],
          ),
        )
      ],
    );
  }
}
