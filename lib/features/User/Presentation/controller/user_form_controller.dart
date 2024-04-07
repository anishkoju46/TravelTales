import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Data/user_repository.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/form_controller.dart';

class UserFormController extends FormController<UserModel> {
  @override
  UserModel build(UserModel? arg) {
    return arg ?? UserModel();
  }

  @override
  update(
      {String? fullName,
      String? email,
      String? phoneNumber,
      String? imageUrl,
      bool? role,
      bool? block,
      List? favourites,
      List? gallery}) {
    state = state.copyWith(
      fullName: fullName ?? state.fullName,
      email: email ?? state.email,
      phoneNumber: phoneNumber ?? state.phoneNumber,
      imageUrl: imageUrl ?? state.imageUrl,
      role: role ?? state.role,
      block: block ?? state.block,
      // favourites: favourites ?? state.favourites,
      // gallery: gallery ?? state.gallery,
    );
  }

  @override
  handleSubmit(BuildContext context) async {
    if (isValidated) {
      if (state != arg) {
        //TODO admin ko lagi list of users
        //ref.read(userListProvider.notifier).handleSubmit(context, model: state);
        //Navigator.pop(context);
        try {
          final user = await UserRepository(
                  token: ref.watch(authNotifierProvider)?.token)
              .editProfile(
            fullName: state.fullName!,
            email: state.email!,
            phoneNumber: state.phoneNumber!,
          );
          ref.read(authNotifierProvider.notifier).update(user);
          CustomSnack.success(context, message: "Profile Updated");
        } catch (e, s) {
          CustomSnack.error(context, message: e.toString());
          // print(e);
          // print(s);
        }
        resetForm();
      } else {
        CustomSnack.info(context, message: "No changes Made");
      }
    }
  }

  @override
  updateState() {
    // TODO: implement updateState
    throw UnimplementedError();
  }
}
