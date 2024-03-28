import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/photo/presentation/photo_screen.dart';
import 'package:traveltales/utility/alertBox.dart';

class CustomImageViewer extends StatefulWidget {
  const CustomImageViewer({super.key, required this.url});
  final String url;

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
          child: Consumer(builder: (context, ref, child) {
            return MyNetworkImage(imageUrl: widget.url);
          }),
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
              onPressed: () {
                AlertBox(
                    confirmText: "Delete",
                    onPressed: () {},
                    title: "Delete Image");
                // Navigator.pop(context);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
        )
      ]),
    ));
  }
}
