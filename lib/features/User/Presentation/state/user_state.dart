import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/controller/user_form_controller.dart';
import 'package:traveltales/features/User/Presentation/controller/user_list_controller.dart';

final userFormProvider = AutoDisposeNotifierProviderFamily<UserFormController,
    UserModel, UserModel?>(UserFormController.new);

final userListProvider =
    AsyncNotifierProvider.autoDispose<UserListController, List<UserModel>>(
        UserListController.new);
