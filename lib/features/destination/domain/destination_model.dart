import 'dart:convert';

import 'package:traveltales/features/category/domain/category_model.dart';

List<DestinationModel> destinationModelFromJson(String str) =>
    List<DestinationModel>.from(
        json.decode(str).map((x) => DestinationModel.fromJson(x)));

String destinationModelToJson(List<DestinationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationModel {
  final String id;
  final String name;
  final Coordinates coordinates;
  final String description;
  final String itinerary;
  final String imageUrl;
  final int ratings;
  final List<Review> review;
  final CategoryModel category;
  final String region;
  final String duration;
  final String maxHeight;
  final String bestSeason;
  final bool isFavourite;

  DestinationModel({
    required this.id,
    required this.name,
    required this.coordinates,
    required this.description,
    required this.itinerary,
    required this.imageUrl,
    required this.ratings,
    required this.review,
    required this.category,
    required this.region,
    required this.duration,
    required this.maxHeight,
    required this.bestSeason,
    this.isFavourite = false,
  });

  DestinationModel copyWith({
    String? id,
    String? name,
    Coordinates? coordinates,
    String? description,
    String? itinerary,
    String? imageUrl,
    int? ratings,
    List<Review>? review,
    CategoryModel? category,
    String? region,
    String? duration,
    String? maxHeight,
    String? bestSeason,
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
        category: category ?? this.category,
        region: region ?? this.region,
        duration: duration ?? this.duration,
        maxHeight: maxHeight ?? this.maxHeight,
        bestSeason: bestSeason ?? this.bestSeason,
      );

  factory DestinationModel.generateDestination({
    String? id,
    String? name,
    Coordinates? coordinates,
    String? description,
    String? itinerary,
    String? imageUrl,
    int? ratings,
    List<Review>? review,
    CategoryModel? category,
    String? region,
    String? duration,
    String? maxHeight,
    String? bestSeason,
  }) =>
      DestinationModel(
          id: id ?? "1",
          name: name ?? "sdf",
          coordinates:
              coordinates ?? Coordinates(longitude: 2.2, latitude: 3.3),
          description: description ?? "hello",
          itinerary: itinerary ?? "day 1",
          imageUrl: imageUrl ?? "assets/langtang/langtang1.jpeg",
          ratings: ratings ?? 5,
          review: review ?? [Review(id: "1", comment: "comment", rating: 5)],
          category: category ?? CategoryModel(name: "Easy", id: "1"),
          region: region ?? "Nepal",
          duration: duration ?? "duration",
          maxHeight: maxHeight ?? "max Height",
          bestSeason: bestSeason ?? "bes season");

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
        review:
            List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
        category: CategoryModel.fromJson(json["category"]),
        region: json["region"],
        duration: json["duration"],
        maxHeight: json["maxHeight"],
        bestSeason: json["bestSeason"],
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
        "category": category.toJson(),
        "region": region,
        "duration": duration,
        "maxHeight": maxHeight,
        "bestSeason": bestSeason
      };
}

class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  Coordinates copyWith({
    double? longitude,
    double? latitude,
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

class Review {
  final String id;
  final String comment;
  final int rating;

  Review({
    required this.id,
    required this.comment,
    required this.rating,
  });

  Review copyWith({
    String? id,
    String? comment,
    int? rating,
  }) =>
      Review(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
      );

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        comment: json["comment"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "rating": rating,
      };
}
