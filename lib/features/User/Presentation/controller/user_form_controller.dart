import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
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
  handleSubmit(BuildContext context) {
    if (isValidated) {
      if (state != arg) {
        ref.read(userListProvider.notifier).handleSubmit(context, model: state);
        //Navigator.pop(context);
        resetForm();
      } else {
        if (kDebugMode) {
          print("No Changes Made");
        }
      }
    }
  }

  @override
  updateState() {
    // TODO: implement updateState
    throw UnimplementedError();
  }
}
