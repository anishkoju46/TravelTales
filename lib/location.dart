// To parse this JSON data, do
//
//     final location = locationFromJson(jsonString);

//import 'package:meta/meta.dart';
import 'dart:convert';

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  String locationName;
  MyCoordinates myCoordinates;
  String locationCaption;
  String description;
  //paxi yeta fuction tanne start point vs end point
  double get locationDistance => 2;
  double locationTemperature;
  double locationRating;
  String imageURL;

  Location(
      {required this.locationName,
      required this.description,
      required this.myCoordinates,
      required this.locationCaption,
      required this.locationTemperature,
      required this.locationRating,
      required this.imageURL});

  Location copyWith({
    String? locationName,
    MyCoordinates? myCoordinates,
    String? locationCaption,
    String? description,
    double? locationTemperature,
    double? locationRating,
    String? imageURL,
  }) =>
      Location(
          locationName: locationName ?? this.locationName,
          myCoordinates: myCoordinates ?? this.myCoordinates,
          locationCaption: locationCaption ?? this.locationCaption,
          description: description ?? this.description,
          locationTemperature: locationTemperature ?? this.locationTemperature,
          locationRating: locationRating ?? this.locationRating,
          imageURL: imageURL ?? this.imageURL);

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationName: json["locationName"],
        description: json["description"],
        myCoordinates: MyCoordinates.fromJson(json["myCoordinates"]),
        locationCaption: json["locationCaption"],
        locationTemperature: json["locationTemperature"],
        locationRating: json["locationRating"],
        imageURL: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "locationName": locationName,
        "description": description,
        "myCoordinates": myCoordinates.toJson(),
        "locationCaption": locationCaption,
        "locationTemperature": locationTemperature,
        "locationRating": locationRating,
        "imageURL": imageURL,
      };
}

class MyCoordinates {
  double longitude;
  double latitude;

  @override
  String toString() {
    return "$longitude $latitude";
  }

  MyCoordinates({
    required this.longitude,
    required this.latitude,
  });

  MyCoordinates copyWith({
    double? longitude,
    double? latitude,
  }) =>
      MyCoordinates(
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  factory MyCoordinates.fromJson(Map<String, dynamic> json) => MyCoordinates(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
