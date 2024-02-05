import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/review/domain/review_model_new.dart';
import 'package:traveltales/features/review/presentation/controller/review_async_list_controller.dart';
import 'package:traveltales/features/review/presentation/controller/review_form_controller.dart';

final reviewListProvider =
    AsyncNotifierProvider.autoDispose<ReviewController, List<ReviewModel>>(
        ReviewController.new);

final reviewFormProvider = AutoDisposeNotifierProviderFamily<
    ReviewFormController, ReviewModel, ReviewModel?>(ReviewFormController.new);
