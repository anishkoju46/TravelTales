import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/destination/presentation/state/destination_state.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';
import 'package:traveltales/utility/alertBox.dart';

class DestinationListItem extends ConsumerWidget {
  const DestinationListItem(
      {super.key, required this.destination, required this.onPressed});
  final DestinationModel destination;
  final Function onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return destinationShowCase(context, ref,
        destination: destination, onPressed: onPressed);
  }

  Padding destinationShowCase(
    BuildContext context,
    WidgetRef ref, {
    required DestinationModel destination,
    required Function onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
      child: InkWell(
        onTap: () {
          onPressed();
        },
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(destination.imageUrl!.first), //TODO
                ),
                // boxShadow: [
                //   BoxShadow(
                //       offset: Offset(4, 4), color: Colors.black, blurRadius: 23)
                // ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.22),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destination.name!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.background),
                    ),
                    RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 17,
                        initialRating: destination.rating!.toDouble(),
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                            ),
                        onRatingUpdate: (value) {})
                    // Text(
                    //   "Ratings: ${destination.rating}/5",
                    //   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    //       fontWeight: FontWeight.w600,
                    //       color: Theme.of(context).colorScheme.background),
                    // ),
                  ],
                ),
              ),
            ),
            //Icon Button
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: ref.read(authNotifierProvider)?.role == false
                    //if user show favourite button, if admin show edit button
                    ? FavouriteButton(destination: destination)
                    : IconButton(
                        onPressed: () {
                          ref
                              .read(destinationListProvider.notifier)
                              .showForm(context, model: destination);
                        },
                        icon: Icon(
                          Icons.edit,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
              ),
            ),
            //Delete Button ho hai
            if (ref.read(authNotifierProvider)!.role!)
              Positioned(
                top: 75,
                right: 15,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertBox(
                                confirmText: "Yes, Delete",
                                onPressed: () {
                                  ref
                                      .read(destinationListProvider.notifier)
                                      .delete(context, destination);
                                },
                                title: "Are you sure?");
                          },
                        );
                      },
                      icon: Icon(Icons.delete, color: Color(0xff798CAB)
                          //Theme.of(context).colorScheme.secondaryContainer,
                          ),
                    )),
              ),
            //using if condition for frontend - role true hunda matra yo edit button dekhaune
            // if (ref.read(authNotifierProvider)!.role!)
            //   Positioned(
            //     top: 15,
            //     left: 15,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).colorScheme.primary,
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(12),
            //         ),
            //       ),
            //       child: IconButton(
            //           onPressed: () {
            //             ref
            //                 .read(destinationListProvider.notifier)
            //                 .showForm(context, model: destination);
            //           },
            //           icon: Icon(
            //             Icons.edit,
            //             color: Colors.green,
            //           )),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
