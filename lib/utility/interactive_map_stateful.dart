import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:example/utils/tile_servers.dart';
// import 'package:example/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:traveltales/utility/custom_location.dart';

class InteractiveMapPage extends StatefulWidget {
  const InteractiveMapPage(
      {Key? key, required this.controller, required this.pin})
      : super(key: key);
  final MapController controller;
  final LatLng pin;

  @override
  InteractiveMapPageState createState() => InteractiveMapPageState();
}

class InteractiveMapPageState extends State<InteractiveMapPage> {
  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation();
  }

  void _fetchCurrentLocation() async {
    final myPosition = await CustomLocation.determinePosition();
    setState(() {
      position = myPosition;
    });
  }

  Position? position;

  // MapController get controller => arg;
  void gotoDefault(MapController controller) async {
    final myPosition = await CustomLocation.determinePosition();
    position = myPosition;
    controller.center = LatLng(
      Angle.degree(position!.latitude),
      Angle.degree(position!.longitude),
    );
    // print(Angle.degree(position!.latitude));
    // print(Angle.degree(position!.longitude));
    setState(() {});
  }

  void _onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(widget.controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
    setState(() {});
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      widget.controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      widget.controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      transformer.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Maps",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
      body: MapLayout(
        controller: widget.controller,
        builder: (context, transformer) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => _onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: _onScaleStart,
            onScaleUpdate: (details) => _onScaleUpdate(details, transformer),
            onTapUp: (details) {
              final location = transformer.toLatLng(details.localPosition);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                      'You have clicked on (${location.longitude}, ${location.latitude}).'),
                ),
              );
            },
            child: Listener(
              behavior: HitTestBehavior.opaque,
              onPointerSignal: (event) {
                if (event is PointerScrollEvent) {
                  final delta = event.scrollDelta.dy / -1000.0;
                  final zoom = clamp(widget.controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
                  setState(() {});
                }
              },
              child: Stack(
                children: [
                  TileLayer(
                    builder: (context, x, y, z) {
                      final tilesInZoom = pow(2.0, z).floor();

                      while (x < 0) {
                        x += tilesInZoom;
                      }
                      while (y < 0) {
                        y += tilesInZoom;
                      }

                      x %= tilesInZoom;
                      y %= tilesInZoom;

                      return CachedNetworkImage(
                        imageUrl: google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Builder(builder: (context) {
                    final offSet = transformer.toOffset(widget.pin);
                    //transformer.toOffset(widget.controller.center);
                    // controller.projection.
                    return Positioned(
                        left: offSet.dx,
                        top: offSet.dy,
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 30,
                            ),
                            // Text(".")
                          ],
                        ));
                  }),
                  if (position != null)
                    Builder(
                      builder: (context) {
                        final secondOffset = transformer.toOffset(
                          LatLng(
                            Angle.degree(position!.latitude),
                            Angle.degree(position!.longitude),
                          ),
                        );
                        return Positioned(
                          left: secondOffset.dx,
                          top: secondOffset.dy,
                          child: Icon(
                            Icons.person_pin_circle,
                            color: Colors.red,
                            size: 30,
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoDefault(widget.controller);
        },
        tooltip: 'My Location',
        child: const Icon(
          Icons.my_location,
          color: Colors.amber,
        ),
      ),
    );
  }

  double clamp(double x, double min, double max) {
    if (x < min) x = min;
    if (x > max) x = max;

    return x;
  }

  String google(int z, int x, int y) {
    //Google Maps
    final url =
        'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

    return url;
  }
}
