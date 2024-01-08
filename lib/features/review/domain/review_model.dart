// import 'dart:convert';

// class ReviewModel {
//   final String id;
//   final String comment;
//   final int rating;

//   ReviewModel({
//     required this.id,
//     required this.comment,
//     required this.rating,
//   });

//   ReviewModel copyWith({
//     String? id,
//     String? comment,
//     int? rating,
//   }) =>
//       ReviewModel(
//         id: id ?? this.id,
//         comment: comment ?? this.comment,
//         rating: rating ?? this.rating,
//       );

//   factory ReviewModel.fromRawJson(String str) =>
//       ReviewModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
//         id: json["id"],
//         comment: json["comment"],
//         rating: json["rating"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "comment": comment,
//         "rating": rating,
//       };
// }
