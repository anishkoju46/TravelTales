import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';

class UserModel extends Equatable {
  @override
  List<Object?> get props =>
      [id, fullName, phoneNumber, role, block, favourites, gallery];

  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
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

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        block: json["block"],
        favourites: json["favourites"] == null
            ? []
            : List<DestinationModel>.from(
                json["favourites"]!.map((x) => DestinationModel.fromJson(x))),
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "role": role,
        "block": block,
        "favourites": favourites == null
            ? []
            : List<dynamic>.from(favourites!.map((x) => x.toJson())),
        "gallery":
            gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
      };
}
