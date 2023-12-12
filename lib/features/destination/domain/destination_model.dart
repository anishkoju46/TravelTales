import 'package:traveltales/features/review/domain/review_model.dart';

import 'dart:convert';

class DestinationModel {
  final String id;
  final String name;
  final Coordinates coordinates;
  final String description;
  final String itinerary;
  final String imageUrl;
  final int ratings;
  final List<ReviewModel> review;

  DestinationModel({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.description,
    required this.itinerary,
    required this.imageUrl,
    required this.ratings,
    required this.review,
  });

  DestinationModel copyWith({
    String? id,
    String? name,
    Coordinates? coordinates,
    String? description,
    String? itinerary,
    String? imageUrl,
    int? ratings,
    List<ReviewModel>? review,
  }) =>
      DestinationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        coordinates: coordinates ?? this.coordinates,
        description: description ?? this.description,
        itinerary: itinerary ?? this.itinerary,
        imageUrl: imageUrl ?? this.imageUrl,
        ratings: ratings ?? this.ratings,
        review: review ?? this.review,
      );

  factory DestinationModel.fromRawJson(String str) =>
      DestinationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        id: json["id"],
        name: json["name"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        description: json["description"],
        itinerary: json["itinerary"],
        imageUrl: json["imageUrl"],
        ratings: json["ratings"],
        review: List<ReviewModel>.from(
            json["review"].map((x) => ReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coordinates": coordinates.toJson(),
        "description": description,
        "itinerary": itinerary,
        "imageUrl": imageUrl,
        "ratings": ratings,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
      };
}

class Coordinates {
  final String longitude;
  final String latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  Coordinates copyWith({
    String? longitude,
    String? latitude,
  }) =>
      Coordinates(
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
      );

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
