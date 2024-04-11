import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Presentation/widgets/imageViewer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.allowFullScreen = true,
    this.color,
    // required this.authController,
  });

  final String url;
  final bool allowFullScreen;
  final Color? color;

  // final UserModel? authController;

  @override
  Widget build(BuildContext context) {
    final assetImage = Image.asset("assets/images/default2.jpeg");

    return GestureDetector(
      onTap: () {
        if (allowFullScreen)
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageViewer(url: url),
          ));
      },
      child: CachedNetworkImage(
        colorBlendMode: BlendMode.colorBurn,
        color: color,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return assetImage;
        },
        imageUrl: url,
        errorWidget: (context, url, error) => assetImage,
      ),
    );
  }
}
