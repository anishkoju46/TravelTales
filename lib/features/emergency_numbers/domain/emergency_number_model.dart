import 'dart:convert';

List<HotlineNumbersModel> hotlineNumbersModelFromJson(String str) =>
    List<HotlineNumbersModel>.from(
        json.decode(str).map((x) => HotlineNumbersModel.fromJson(x)));

String hotlineNumbersModelToJson(List<HotlineNumbersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotlineNumbersModel {
  final String? phoneNumber;
  final String? organizationName;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  HotlineNumbersModel({
    this.phoneNumber,
    this.organizationName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  HotlineNumbersModel copyWith({
    String? phoneNumber,
    String? organizationName,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      HotlineNumbersModel(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        organizationName: organizationName ?? this.organizationName,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory HotlineNumbersModel.fromRawJson(String str) =>
      HotlineNumbersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HotlineNumbersModel.fromJson(Map<String, dynamic> json) =>
      HotlineNumbersModel(
        phoneNumber: json["phoneNumber"],
        organizationName: json["organizationName"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "organizationName": organizationName,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
