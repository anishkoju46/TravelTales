import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/destination/domain/destination_model.dart';
import 'package:traveltales/features/favourite/presentation/controller/favourite_controller.dart';

class FavouriteButton extends ConsumerWidget {
  const FavouriteButton({super.key, required this.destination});
  final DestinationModel destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favourites = ref.watch(favouriteProvider);
    final isFavourite = favourites.containsKey(destination.id);
    return IconButton(
      onPressed: () {
        ref.read(favouriteProvider.notifier).handleFavourite(destination);
      },
      icon: Icon(
        isFavourite ? Icons.star_outline : Icons.star,
        color: isFavourite
            ? Theme.of(context).colorScheme.secondaryContainer
            : Theme.of(context).colorScheme.background,
      ),
    );
  }
}
