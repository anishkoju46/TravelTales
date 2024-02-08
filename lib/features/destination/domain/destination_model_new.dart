import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';

import 'package:traveltales/features/review/domain/review_model_new.dart';

List<DestinationModel> destinationModelFromJson(String str) =>
    List<DestinationModel>.from(
        json.decode(str).map((x) => DestinationModel.fromJson(x)));

String destinationModelToJson(List<DestinationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DestinationModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        name,
        coordinates,
        description,
        itinerary,
        imageUrl,
        rating,
        reviews,
        region,
        bestSeason,
        duration,
        maxHeight,
        category,
        views,
        favouriteCount
      ];

  final String? id;
  final String? name;
  final Coordinates? coordinates;
  final String? description;
  final List<String>? itinerary;
  final List<String>? imageUrl;
  final double? rating;
  final List<ReviewModel>? reviews; //review model hai
  final String? region;
  final String? bestSeason;
  final String? duration;
  final String? maxHeight;
  final CategoryModel? category; //category model hai
  final int? views;
  final int? favouriteCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  DestinationModel({
    this.id,
    this.name,
    this.coordinates,
    this.description,
    this.itinerary,
    this.imageUrl,
    this.rating,
    this.reviews,
    this.region,
    this.bestSeason,
    this.duration,
    this.maxHeight,
    this.category,
    this.views,
    this.favouriteCount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  DestinationModel copyWith({
    String? id,
    String? name,
    Coordinates? coordinates,
    String? description,
    List<String>? itinerary,
    List<String>? imageUrl,
    double? rating,
    List<ReviewModel>? reviews,
    String? region,
    String? bestSeason,
    String? duration,
    String? maxHeight,
    CategoryModel? category,
    int? views,
    int? favouriteCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      DestinationModel(
        id: id ?? this.id,
        name: name ?? this.name,
        coordinates: coordinates ?? this.coordinates,
        description: description ?? this.description,
        itinerary: itinerary ?? this.itinerary,
        imageUrl: imageUrl ?? this.imageUrl,
        rating: rating ?? this.rating,
        reviews: reviews ?? this.reviews,
        region: region ?? this.region,
        bestSeason: bestSeason ?? this.bestSeason,
        duration: duration ?? this.duration,
        maxHeight: maxHeight ?? this.maxHeight,
        category: category ?? this.category,
        views: views ?? this.views,
        favouriteCount: favouriteCount ?? this.favouriteCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory DestinationModel.fromRawJson(String str) =>
      DestinationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        id: json["_id"],
        name: json["name"],
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
        description: json["description"],
        itinerary: json["itinerary"] == null
            ? []
            : List<String>.from(json["itinerary"]!.map((x) => x)),
        imageUrl: json["imageUrl"] == null
            ? []
            : List<String>.from(json["imageUrl"]!.map((x) => x)),
        rating: json["rating"] == null ? 0.0 : json["rating"].toDouble(),
        reviews: json["reviews"] == null
            ? []
            : List<ReviewModel>.from(
                json["reviews"]!.map((x) => ReviewModel.fromJson(x))),
        region: json["region"],
        bestSeason: json["bestSeason"],
        duration: json["duration"],
        maxHeight: json["maxHeight"],
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        views: json["views"],
        favouriteCount: json["favouriteCount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "coordinates": coordinates?.toJson(),
        "description": description,
        "itinerary": itinerary == null
            ? []
            : List<dynamic>.from(itinerary!.map((x) => x)),
        "imageUrl":
            imageUrl == null ? [] : List<dynamic>.from(imageUrl!.map((x) => x)),
        "rating": rating,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "region": region,
        "bestSeason": bestSeason,
        "duration": duration,
        "maxHeight": maxHeight,
        "category": category?.toJson(),
        "views": views,
        "favouriteCount": favouriteCount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Coordinates {
  final String? type;
  final List<double>? coordinates;
  final String? id;

  Coordinates({
    this.type,
    this.coordinates,
    this.id,
  });

  Coordinates copyWith({
    String? type,
    List<double>? coordinates,
    String? id,
  }) =>
      Coordinates(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
        id: id ?? this.id,
      );

  factory Coordinates.fromRawJson(String str) =>
      Coordinates.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "_id": id,
      };
}
