import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Equatable {
  @override
  List<Object?> get props => [id, name, user];

  final String? id;
  final String? name;
  final UserModel? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  CategoryModel({
    this.id,
    this.name,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    UserModel? user,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        user: user ?? this.user,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["name"] == "All" ? null : json["_id"],
        name: json["name"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
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
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
