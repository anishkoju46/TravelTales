import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';

class FavouriteButton extends ConsumerWidget {
  const FavouriteButton({super.key, required this.destination});
  final DestinationModel destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouriteProvider);
    final isFavourite = favourites.containsKey(destination.id);
    return InkWell(
      onTap: () {
        ref.read(favouriteProvider.notifier).handleFavourite(destination);
      },
      child: Container(
        padding: EdgeInsets.all(7),
        child: Icon(
          isFavourite ? Icons.star : Icons.star_outline,
          color: isFavourite
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
