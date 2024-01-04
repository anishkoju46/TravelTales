import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';

List<ReviewModel> reviewModelFromJson(String str) => List<ReviewModel>.from(
    json.decode(str).map((x) => ReviewModel.fromJson(x)));

String reviewModelToJson(List<ReviewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewModel extends Equatable {
  @override
  List<Object?> get props => [id, review, user, rating, destination];

  final String? id;
  final String? review;
  final UserModel? user;
  final int? rating;
  final DestinationModel? destination;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  ReviewModel({
    this.id,
    this.review,
    this.user,
    this.rating,
    this.destination,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  ReviewModel copyWith({
    String? id,
    String? review,
    UserModel? user,
    int? rating,
    DestinationModel? destination,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        review: review ?? this.review,
        user: user ?? this.user,
        rating: rating ?? this.rating,
        destination: destination ?? this.destination,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory ReviewModel.fromRawJson(String str) =>
      ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["_id"],
        review: json["review"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        rating: json["rating"],
        destination: json["destination"] == null
            ? null
            : DestinationModel.fromJson(json["destination"]),
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
        "review": review,
        "user": user?.toJson(),
        "rating": rating,
        "destination": destination?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
