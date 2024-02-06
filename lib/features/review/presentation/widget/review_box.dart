import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';

//eutaboxko code yesma
//reviewko model ni
class ReviewBox extends StatelessWidget {
  const ReviewBox({
    super.key,
    required this.review,
  });
  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
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
            children: [
              //imageuserko
              // Container(
              //   margin: const EdgeInsets.only(right: 10),
              //   height: 40,
              //   width: 50,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     image: DecorationImage(
              //       image: AssetImage("${review.user?.imageUrl}"),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //userkoemail first child
                    // Text("${review.userModel?.userDetail.email}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${review.user?.email}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(DateFormat.yMMMd().format(review.createdAt!)),
                      ],
                    ),
                    Text("${review.review}"),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
