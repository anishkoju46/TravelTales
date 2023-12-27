import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/utility/form_controller.dart';

class UserFormController extends FormController<UserModel> {
  @override
  UserModel build(UserModel? arg) {
    return arg ?? UserModel.empty();
  }

  @override
  update({
    String? fullName,
    bool? role,
    bool? block,
    String? email,
    String? imageUrl,
    String? phoneNumber,
  }) {
    state = state.copyWith(
      fullName: fullName ?? state.fullName,
      role: role ?? state.role,
      block: block ?? state.block,
      userDetail: state.userDetail.copyWith(
          email: email ?? state.userDetail.email,
          imageUrl: imageUrl ?? state.userDetail.imageUrl,
          phoneNumber: phoneNumber ?? state.userDetail.phoneNumber),
    );
  }

  @override
  handleSubmit(BuildContext context) {
    if (isValidated) {
      if (state != arg) {
        ref.read(userListProvider.notifier).handleSubmit(state);
        //Navigator.pop(context);
        resetForm();
      } else {
        if (kDebugMode) {
          print("No Changes Made");
        }
      }
    }
  }
}
