import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends Equatable {
  @override
  List<Object?> get props => [id, fullName, role, userDetail];

  final String id;
  final String fullName;
  final bool role;
  final bool block;
  final UserDetail userDetail;

  const UserModel({
    required this.id,
    required this.fullName,
    this.role = false,
    this.block = false,
    required this.userDetail,
  });

  //aile lai kam chalau named constructor
  factory UserModel.generateUser(
          {String? id,
          String? fullName,
          bool? role,
          String? phoneNumber,
          String? imageUrl,
          String? email,
          bool? block}) =>
      UserModel(
        id: "1",
        fullName: fullName ?? "Anish Koju",
        role: false,
        block: false,
        userDetail: UserDetail(
            email: email ?? "aaaa",
            imageUrl: imageUrl ?? "assets/images/default2.jpeg",
            phoneNumber: phoneNumber ?? "9999"),
      );

  UserModel copyWith({
    String? id,
    String? fullName,
    bool? role,
    bool? block,
    UserDetail? userDetail,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        role: role ?? this.role,
        block: block ?? this.block,
        userDetail: userDetail ?? this.userDetail,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        role: json["role"],
        block: json["block"] ?? false,
        userDetail: UserDetail.fromJson(json["userDetail"]),
      );

  factory UserModel.empty() => UserModel(
      id: Random().nextInt(100).toString(),
      fullName: "",
      role: false,
      block: false,
      userDetail: UserDetail(email: "", imageUrl: "imageUrl", phoneNumber: ""));

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "role": role,
        "block": block,
        "userDetail": userDetail.toJson(),
      };
}

class UserDetail extends Equatable {
  @override
  List<Object?> get props => [email, imageUrl, phoneNumber];

  final String? email;
  final String? imageUrl;
  final String phoneNumber;

  const UserDetail({
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
  });

  UserDetail copyWith({
    String? email,
    String? imageUrl,
    String? phoneNumber,
  }) =>
      UserDetail(
        email: email ?? this.email,
        imageUrl: imageUrl ?? this.imageUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory UserDetail.fromRawJson(String str) =>
      UserDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        email: json["email"],
        imageUrl: json["imageUrl"],
        phoneNumber: json["phoneNumber"],
      );

  factory UserDetail.empty() =>
      UserDetail(email: "", imageUrl: "", phoneNumber: "");

  Map<String, dynamic> toJson() => {
        "email": email,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
      };
}
