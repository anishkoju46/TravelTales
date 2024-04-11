import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CustomLocation {
  static Future<Position?> determinePosition() async {
    bool serviceEnabled; // location on xa ki off
    LocationPermission permission; // userle location diyo kinai

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const SnackBar(
        content: Text("Please keep your location on"),
        duration: Duration(seconds: 2),
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const SnackBar(
          content: Text("Location Permission is Denied"),
          duration: Duration(seconds: 2),
        );
      }
    }
    //if user denies location forever
    if (permission == LocationPermission.deniedForever) {
      const SnackBar(
        content: Text("Permission is denied forever"),
        duration: Duration(seconds: 2),
      );
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  static Future<Placemark?> place(Position position) async {
    Placemark? placemark;
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      placemark = placemarks[0];
      // setState(() {
      //   currentposition = position;
      //   currentLocation = "${place.locality}, ${place.country}, ${place.name}";
      // });
    } catch (e) {
      print(e);
    }
    return placemark;
  }
}
