import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/photo/presentation/photo_screen.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_snack.dart';

class CustomImageViewer extends StatefulWidget {
  const CustomImageViewer(
      {super.key,
      required this.url,
      this.index,
      this.showDeleteButton = false});
  final String url;
  final int? index;
  final bool showDeleteButton;

  @override
  State<CustomImageViewer> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends State<CustomImageViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: InteractiveViewer(
              child: MyNetworkImage(
            imageUrl: widget.url,
            allowFullScreen: false,
          )),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        if (widget.showDeleteButton)
          Positioned(
            right: 0,
            top: 0,
            child: Consumer(builder: (context, ref, child) {
              return IconButton(
                  onPressed: () async {
                    final index = widget.index;
                    final urll = ref
                        .read(authNotifierProvider.notifier)
                        .getGalleryImageUrlForDeletion(index!);
                    print(urll);

                    var imageValue = await UserRepository(
                            token: ref.watch(authNotifierProvider)?.token)
                        .deleteGalleryImage(imageUrl: urll);

                    print(imageValue?.gallery);

                    if (imageValue != null) {
                      final currentUser = ref.watch(authNotifierProvider);

                      final updatedUser = currentUser!.copyWith(
                          gallery: currentUser.gallery!..remove(urll));

                      await ref
                          .read(authNotifierProvider.notifier)
                          .update(updatedUser);
                    }

                    Navigator.pop(context);
                    CustomSnack.info(context, message: "Image Deleted");
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ));
            }),
          )
      ]),
    ));
  }
}
