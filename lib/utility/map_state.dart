import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class MapState {
  final Offset? dragStart;
  final double scaleStart;
  MapState({this.dragStart, required this.scaleStart});
}

final mapProvider =
    NotifierProvider.family<MapStateContoller, MapState, MapController>(
        MapStateContoller.new);

class MapStateContoller extends FamilyNotifier<MapState, MapController> {
  @override
  MapState build(MapController arg) {
    return MapState(scaleStart: 1.0);
  }

  setState() {
    state = MapState(dragStart: state.dragStart, scaleStart: state.scaleStart);
  }

  update({Offset? dragStart, double? scaleStart}) {
    state = MapState(
        dragStart: dragStart ?? state.dragStart,
        scaleStart: scaleStart ?? state.scaleStart);
  }

  MapController get controller => arg;

  void gotoDefault() {
    controller.center = const LatLng(
        Angle.degree(27.67291697667757), Angle.degree(85.43107431974025));
    setState();
  }

  void onDoubleTap(MapTransformer transformer, Offset position) {
    const delta = 0.5;
    final zoom = clamp(controller.zoom + delta, 2, 18);

    transformer.setZoomInPlace(zoom, position);
  }

  Offset? _dragStart;
  double _scaleStart = 1.0;
  void onScaleStart(ScaleStartDetails details) =>
      update(dragStart: details.focalPoint, scaleStart: 1.0);

  void onScaleUpdate(ScaleUpdateDetails details, MapTransformer transformer) {
    final scaleDiff = details.scale - state.scaleStart;
    update(scaleStart: details.scale);

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - state.dragStart!;
      update(dragStart: now);
      transformer.drag(diff.dx, diff.dy);
    }
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

//'https://maps.googleapis.com/maps/api/staticmap?center=Z%C3%BCrich&zoom=12&size=400x400&key=AIzaSyBSCHfxPsKgGH4FDQPyS22efOituuMMLFY';



















//=================
//Record not effective for state  management

// final anotherProvider = NotifierProvider<MapStateControllerRecord,
//     ({Offset? dragStart, double scaleStart})>(MapStateControllerRecord.new);

// class MapStateControllerRecord
//     extends Notifier<({Offset? dragStart, double scaleStart})> {
//   @override
//   build() {
//     return (dragStart: null, scaleStart: 1.0);
//   }

//   update(Offset? dragStart, double? scaleStart) {
//     state = (
//       dragStart: dragStart ?? state.dragStart,
//       scaleStart: scaleStart ?? state.scaleStart
//     );
//   }
// }

//copywith dubai ma banaunu paryo
//record ma 