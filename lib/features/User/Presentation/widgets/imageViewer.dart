import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.url});
  final String url;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              child: InteractiveViewer(
                child: CustomNetworkImage(
                  url: widget.url,
                  allowFullScreen: false,
                  // color: Colors.black26,
                ),
              ),
            ),

            // IgnorePointer(
            //   child: ClipPath(
            //     clipper: CustomClip(width: size.width, height: size.height),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            //       child: Container(
            //         color: Colors.black38,
            //       ),
            //     ),
            //   ),
            // ),

            // IgnorePointer(
            //   child: CustomPaint(
            //     painter: CustomPaintClass(),
            //     size: size,
            //   ),
            // ),

            // Center(
            //   // BackdropFilter(
            //   //   filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            //   child: Container(
            //     height: 200,
            //     width: 200,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: Colors.white),
            //         // color: Colors.black26,
            //         shape: BoxShape.circle),
            //   ),
            // ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),

            Consumer(builder: (context, ref, child) {
              return Positioned(
                right: 0,
                child: IconButton(
                    onPressed: () async {
                      //method use garnu paryo
                      var imageValue = await UserRepository(
                              token: ref.watch(authNotifierProvider)?.token)
                          .deleteProfileUrl();

                      final currentUser = ref.watch(authNotifierProvider);
                      ref.read(authNotifierProvider.notifier).update(
                          currentUser!.copyWith(imageUrl: imageValue.imageUrl));

                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              );
            })
          ],
        ),
      ),
    );
  }
}

class CustomPaintClass extends CustomPainter {
  final Color color;
  CustomPaintClass({this.color = Colors.black38});

  @override
  void paint(Canvas canvas, Size size) {
    // final roundedRectangle = RRect.fromRectAndRadius(
    //     Rect.fromLTWH((size.width) / 2, (size.width), 100, 100),
    //     Radius.circular(10));

    final circle = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 150);

    final Path _path = Path()
      ..addOval(circle)
      // ..addRRect(roundedRectangle)
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;

    final Paint paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 2;

    canvas.drawPath(_path, paint..color = color);

    // canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), paint);

    // canvas.drawRect(
    //     Rect.fromLTWH((size.width / 2) - 50, (size.height / 4) - 50, 100, 100),
    //     paint..color = Colors.red);

    canvas.drawCircle(
        circle.center,
        150,
        paint
          ..style = PaintingStyle.stroke
          ..color = Colors.black45
        //..strokeWidth = 5
        );

    // canvas.drawRRect(roundedRectangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CustomClip extends CustomClipper<Path> {
  final Path _path;

  CustomClip(
      {required double width, required double height, double radius = 150})
      : _path = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(width / 2, height / 2), radius: radius))
          ..addRect(Rect.fromLTWH(0, 0, width, height))
          ..fillType = PathFillType.evenOdd;

  @override
  Path getClip(Size size) => _path;

  @override
  bool shouldReclip(covariant CustomClip oldClipper) {
    return oldClipper._path != _path;
  }
}
