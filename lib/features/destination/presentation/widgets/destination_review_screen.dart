import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/review/presentation/review_box.dart';

class DestinationReview extends StatelessWidget {
  const DestinationReview({super.key, required this.destination});
  final DestinationModel destination;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: destination.reviews!.length,
                  itemBuilder: (context, index) {
                    return ReviewBox(review: destination.reviews![index]);
                  })),
        ],
      ),
    ));
  }
}
