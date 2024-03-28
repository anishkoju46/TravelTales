import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.url});
  final String url;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.black,
        // ),
        body: Stack(
          children: [
            Center(
              child: CustomNetworkImage(
                url: widget.url,
                allowFullScreen: false,
                color: Colors.black26,
              ),
            ),
            Center(
              // BackdropFilter(
              //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    // color: Colors.black26,
                    shape: BoxShape.circle),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
