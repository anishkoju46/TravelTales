import 'package:flutter/src/widgets/framework.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/features/review/data/repository/review_repository.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/state/review_state.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/form_controller.dart';

class ReviewFormController extends FormController<ReviewModel> {
  @override
  ReviewModel build(ReviewModel? arg) {
    return arg ?? ReviewModel();
  }

  @override
  update(
      {String? review,
      DestinationModel? destination,
      UserModel? user,
      int? rating}) {
    state = state.copyWith(
        review: review ?? state.review,
        destination: destination ?? state.destination,
        user: user ?? state.user,
        rating: rating ?? state.rating);
  }

  @override
  handleSubmit(BuildContext context) async {
    if (isValidated) {
      if (state != arg) {
        if (state.rating != null && state.review?.isNotEmpty != null) {
          try {
            final review = await ReviewRepository(
                    token: ref.watch(authNotifierProvider)?.token)
                .addReview(
                    review:
                        state.copyWith(user: ref.read(authNotifierProvider)));
            ref.read(reviewListProvider.notifier).handleSubmit(review);
            CustomSnack.success(context, message: "Review Added");
          } catch (e, s) {
            CustomSnack.error(context, message: e.toString());
          }
        } else {
          CustomSnack.error(context, message: "Invalid Review");
        }
        resetForm();
      } else {
        CustomSnack.info(context, message: "No changes Made");
      }
    }
  }

  // @override
  // handleSubmit(BuildContext context) async {
  //   if (isValidated) {
  //     if (state != arg) {
  //       try {
  //         final review = await ReviewRepository(
  //                 token: ref.watch(authNotifierProvider)?.token)
  //             .addReview(review: state);
  //         ref.read(reviewListProvider.notifier).handleSubmit(review);
  //         CustomSnack.success(context, message: "Review Added");
  //       } catch (e, s) {
  //         CustomSnack.error(context, message: e.toString());
  //       }
  //       resetForm();
  //     } else {
  //       CustomSnack.info(context, message: "No changes Made");
  //     }
  //   }
  // }
}
