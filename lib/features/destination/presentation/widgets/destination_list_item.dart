import 'package:flutter/material.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_button.dart';

class DestinationListItem extends StatelessWidget {
  const DestinationListItem(
      {super.key, required this.destination, required this.onPressed});
  final DestinationModel destination;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return destinationShowCase(context,
        destination: destination, onPressed: onPressed);
  }

  Padding destinationShowCase(
    BuildContext context, {
    required DestinationModel destination,
    String explore = "Explore",
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
                  image: AssetImage(destination.imageUrl),
                ),
                // boxShadow: [
                //   BoxShadow(
                //       offset: Offset(4, 4), color: Colors.black, blurRadius: 23)
                // ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destination.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.background),
                    ),
                    Text(
                      explore,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.background),
                    ),
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
                  child: FavouriteButton(destination: destination)),
            )
          ],
        ),
      ),
    );
  }
}
