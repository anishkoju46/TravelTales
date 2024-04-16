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
      CustomSnack.success(context, message: "User Deleted");
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }

  blockUser(BuildContext context, UserModel user,
      {required bool isBlock}) async {
    try {
      if (isBlock) {
        await UserRepository(token: ref.watch(authNotifierProvider)?.token)
            .blockUser(id: user.id!);
        // remove(user);
        CustomSnack.info(context, message: "User Unblocked Sucessfully");
      } else {
        await UserRepository(token: ref.watch(authNotifierProvider)?.token)
            .blockUser(id: user.id!);
        // remove(user);
        CustomSnack.error(context, message: "User Blocked Sucessfully");
      }
    } catch (e, s) {
      CustomSnack.error(context, message: e.toString());
    }
  }

  @override
  bool findById(UserModel element, [UserModel? current, String? id]) {
    return element.id == ((current?.id) ?? id);
  }

  changePassword(BuildContext context,
      {required String currentPassword,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      if (currentPassword.isNotEmpty &&
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        if (newPassword == confirmPassword) {
          await UserRepository(token: ref.watch(authNotifierProvider)?.token)
              .changePassword(
                  currentPassword: currentPassword, newPassword: newPassword);
          CustomSnack.success(context, message: "Password Changed");
        } else {
          CustomSnack.info(context, message: "Incorrect new Password");
        }
      } else {
        CustomSnack.info(context, message: "Fields are Empty. Try Again");
      }
    } catch (e, s) {
      // print("$e $s");
      CustomSnack.error(context, message: e.toString());
    }
  }

  // addToFavourites(BuildContext context, DestinationModel destination) async {
  //   // final destination =
  //   //     ref.read(destinationListProvider.notifier).currentDestination;
  //   try {
  //     await UserRepository(token: ref.watch(authNotifierProvider)?.token)
  //         .addToFavourites(id: destination.id!);
  //     CustomSnack.success(context, message: "Added to Favourites");
  //   } catch (e, s) {
  //     CustomSnack.error(context, message: e.toString());
  //   }
  // }
}
