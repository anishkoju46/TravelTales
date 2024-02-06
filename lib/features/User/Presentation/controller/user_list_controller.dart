import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/widgets/edit_profile_screen.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/repository.dart';

class UserListController extends AsyncListController<UserModel> {
  @override
  bool findById(UserModel element, UserModel current) =>
      element.id == element.id;

  @override
  Widget formWidget(UserModel? model) => EditProfileScreen(userModel: model);

  @override
  List<UserModel> fromStorage(String data) => userModelFromJson(data);

  @override
  Repository<UserModel> get respository =>
      UserRepository(token: ref.watch(authNotifierProvider)?.token);

  @override
  String toStorage() => userModelToJson(state.value!);

  Future<UserModel> fetchOneUser({required String id}) {
    return UserRepository(token: ref.watch(authNotifierProvider)?.token)
        .fetchOne(id: id);
  }

  delete(BuildContext context, UserModel user) async {
    try {
      await UserRepository(token: ref.watch(authNotifierProvider)?.token)
          .delete(user.id!);
      remove(user);
      CustomSnack.success(context, message: "Destination Deleted");
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }
}
