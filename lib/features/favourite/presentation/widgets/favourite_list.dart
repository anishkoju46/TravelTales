import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';

class FavouriteList extends ConsumerWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final scrollController = ref.read(favouriteProvider.notifier);
    final favouriteList = ref.watch(favouriteProvider).entries.toList();
    return ListView.builder(
        // controller: scrollController.listScrollController,
        itemCount: favouriteList.length,
        itemBuilder: (BuildContext context, int index) {
          return favouriteShowCase(context,
              destination: favouriteList[index].value, onPressed: () {});
        });
  }

  Padding favouriteShowCase(
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
            Consumer(builder: (context, ref, child) {
              return Positioned(
                top: 15,
                right: 15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(favouriteProvider.notifier)
                          .removeFromFavourite(destination.id);
                    },
                    icon: Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}