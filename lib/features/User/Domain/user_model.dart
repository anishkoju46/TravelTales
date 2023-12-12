import 'dart:convert';

class UserModel {
  final String id;
  final String fullName;
  final bool role;
  final UserDetail userDetail;

  UserModel({
    required this.id,
    required this.fullName,
    required this.role,
    required this.userDetail,
  });

  //aile lai kam chalau named constructor
  factory UserModel.generateUser({
    String? id,
    String? fullName,
    required bool role,
    String? phoneNumber,
    String? imageUrl,
    String? email,
  }) =>
      UserModel(
        id: "1",
        fullName: fullName ?? "Anish Koju",
        role: role,
        userDetail: UserDetail(
            email: email ?? "aaaa",
            imageUrl: "asdf",
            phoneNumber: phoneNumber ?? "9999"),
      );

  UserModel copyWith({
    String? id,
    String? fullName,
    bool? role,
    UserDetail? userDetail,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        role: role ?? this.role,
        userDetail: userDetail ?? this.userDetail,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["fullName"],
        role: json["role"],
        userDetail: UserDetail.fromJson(json["userDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "role": role,
        "userDetail": userDetail.toJson(),
      };
}

class UserDetail {
  final String? email;
  final String? imageUrl;
  final String phoneNumber;

  UserDetail({
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

  Map<String, dynamic> toJson() => {
        "email": email,
        "imageUrl": imageUrl,
        "phoneNumber": phoneNumber,
      };
}
