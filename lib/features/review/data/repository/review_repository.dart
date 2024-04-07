import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/utility/repository.dart';

class ReviewRepository extends Repository<ReviewModel> {
  ReviewRepository({super.token, super.client});

  @override
  String get endPoint => "reviews";

  @override
  ReviewModel fromJson(String json) => ReviewModel.fromRawJson(json);

  @override
  List<ReviewModel> listfromJson(String json) => reviewModelFromJson(json);

  Future<List<ReviewModel>> fetchByDestination({String? id}) async {
    return await fetch(path: "/destinations/", param: "$id");
  }

  Future<ReviewModel> addReview({required ReviewModel review}) async {
    return await add(data: {
      "review": review.review,
      "destination": review.destination?.id,
      "user": review.user?.id,
      "rating": review.rating,
    });
  }
}
