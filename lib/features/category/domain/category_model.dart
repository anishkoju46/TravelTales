import 'dart:convert';

import 'package:equatable/equatable.dart';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String userModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends Equatable {
  @override
  List<Object?> get props => [id, name, userId];

  final String name;
  final String id;
  final String? userId;

  CategoryModel({
    required this.name,
    required this.id,
    this.userId,
  });

  CategoryModel copyWith({
    String? name,
    String? id,
    String? userId,
  }) =>
      CategoryModel(
        name: name ?? this.name,
        id: id ?? this.id,
        userId: userId ?? this.userId,
      );


  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
        id: json["id"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "userId": userId,
      };
}
