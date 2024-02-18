import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:traveltales/features/map/presentation/controller/new_map_controller.dart';

class TheMap extends ConsumerStatefulWidget {
  TheMap({super.key, required this.controller, required this.pin});
  final MapController controller;
  final LatLng pin;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewMapScreen();
}

class _NewMapScreen extends ConsumerState<TheMap> {
  late final NewMapStateContoller mapController;

  @override
  void initState() {
    super.initState();
    mapController = NewMapStateContoller(setStateFn: () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mapProviderController = mapController;

    // final mapState = ref.watch(mapProviderController);

    // final mapController = ref.read(mapProviderController.notifier);

    // print(controller.zoom);
    // print(mapState.hashCode);
    // print(mapProviderController.hashCode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: MapLayout(
        controller: widget.controller,
        builder: (context, transformer) {
          // print(controller.hasListeners);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => mapController.onDoubleTap(
                transformer, details.localPosition,
                controller: widget.controller),
            onScaleStart: mapController.onScaleStart,
            onScaleUpdate: (details) => mapController.onScaleUpdate(
                details, transformer,
                controller: widget.controller),
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
                  final zoom = mapController.clamp(
                      widget.controller.zoom + delta, 2, 18);

                  transformer.setZoomInPlace(zoom, event.localPosition);
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
                        imageUrl: mapController.google(z, x, y),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      final offSet = transformer.toOffset(widget.pin);
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
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.gotoDefault(widget.controller);
        },
        tooltip: 'My Location',
        child: const Icon(
          Icons.my_location,
          color: Colors.amber,
        ),
      ),
    );
  }
}
