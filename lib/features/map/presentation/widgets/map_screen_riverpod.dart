import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map/map.dart';
import 'package:traveltales/features/map/presentation/state/map_state.dart';

class MapScreenNew extends ConsumerWidget {
  const MapScreenNew({super.key, required this.controller, required this.pin});
  final MapController controller;
  final pin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapProviderController = mapProvider(controller);
    final mapState = ref.watch(mapProviderController);
    final mapController = ref.read(mapProviderController.notifier);

    // print(mapController.arg.hasListeners);
    // print(controller.zoom);
    // print(mapState.hashCode);
    print(mapProviderController.hashCode);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Map'),
      ),
      body: MapLayout(
        controller: mapController.controller,
        builder: (context, transformer) {
          // print(controller.hasListeners);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTapDown: (details) => mapController.onDoubleTap(
              transformer,
              details.localPosition,
            ),
            onScaleStart: mapController.onScaleStart,
            onScaleUpdate: (details) =>
                mapController.onScaleUpdate(details, transformer),
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
                      mapController.arg.zoom + delta, 2, 18);

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
                      final offSet = transformer.toOffset(pin);
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
        onPressed: mapController.gotoDefault,
        tooltip: 'My Location',
        child: const Icon(
          Icons.my_location,
          color: Colors.amber,
        ),
      ),
    );
  }
}
