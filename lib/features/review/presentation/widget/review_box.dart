import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/state/review_state.dart';

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
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: review.user!.imageUrl!.isEmpty
                        ? AssetImage("assets/images/default2.jpeg")
                        : NetworkImage(
                                "http://10.0.2.2:8000/${review.user?.imageUrl?.replaceAll('\\', '/')}")
                            as ImageProvider<Object>
                    // image: AssetImage(review.user!.imageUrl!.isEmpty
                    //     ? "assets/images/default2.jpeg"
                    //     : "${review.user?.imageUrl}")
                    ,
                  ),
                ),
                // child: Consumer(builder: (context, ref, child) {
                //   final assetImage = Image.asset("assets/images/default2.jpeg");
                //   return ClipRRect(
                //     borderRadius: BorderRadius.circular(100),
                //     child: CachedNetworkImage(
                //       imageUrl: ref.read(reviewFormProvider(user)),
                //       errorWidget: (context, url, error) => assetImage,
                //       // placeholder: (context, url) => ,
                //     ),
                //   );
                // }),
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
                IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ],
          ),
        )
      ],
    );
  }
}
