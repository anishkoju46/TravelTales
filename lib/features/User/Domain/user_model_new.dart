import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNumber,
        imageUrl,
        role,
        block,
        favourites,
        gallery
      ];

  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? imageUrl;
  final bool? role;
  final bool? block;
  final List<DestinationModel>? favourites; //yeta destination hunu parxa hai
  final List<String>? gallery;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? token;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.role,
    this.block,
    this.favourites,
    this.gallery,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.token,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? imageUrl,
    bool? role,
    bool? block,
    List<DestinationModel>? favourites,
    List<String>? gallery,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? token,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        imageUrl: imageUrl ?? this.imageUrl,
        role: role ?? this.role,
        block: block ?? this.block,
        favourites: favourites ?? this.favourites,
        gallery: gallery ?? this.gallery,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        token: token ?? this.token,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson([bool fromServer = true]) => json.encode(toJson(fromServer));

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        imageUrl: json["imageUrl"],
        role: json["role"],
        block: json["block"] ?? false,
        favourites: json["favourites"] == null
            ? []
            : List<DestinationModel>.from(json["favourites"]!.map((x) =>
                x is String
                    ? DestinationModel(id: x)
                    : DestinationModel.fromJson(x))),
        gallery: json["gallery"] == null
            ? []
            : List<String>.from(json["gallery"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
      );

  Map<String, dynamic> toJson([bool fromServer = true]) => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "imageUrl": imageUrl,
        "role": role,
        "block": block,
        "favourites": favourites == null
            ? []
            : List<dynamic>.from(favourites!.map((x) => x.toJson(fromServer))),
        "gallery":
            gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
      };
}
