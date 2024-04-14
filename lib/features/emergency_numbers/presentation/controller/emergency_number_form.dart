import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/emergency_numbers/data/emergency_number_repository.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/state/emergency_state.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/form_controller.dart';

class HotlineNumberController extends FormController<HotlineNumbersModel> {
  @override
  HotlineNumbersModel build(HotlineNumbersModel? arg) {
    return arg ?? HotlineNumbersModel();
  }

  @override
  handleSubmit(BuildContext context, {bool isAdd = false}) async {
    if (state != arg) {
      try {
        final repository =
            HotlineRepository(token: ref.watch(authNotifierProvider)?.token);
        if (isAdd) {
          final hotlineNumber = await HotlineRepository(
                  token: ref.watch(authNotifierProvider)?.token)
              .addHotlineNumber(
                  numbers: state.copyWith(phoneNumber: state.phoneNumber));
          ref.read(hotlineListProvider.notifier).handleSubmit(hotlineNumber);
          CustomSnack.success(context, message: "Hotline Number Added");
        } else {
          final hotlineNumber =
              await repository.editHotlineNumber(numbers: state);
          ref.read(hotlineListProvider.notifier).handleSubmit(hotlineNumber);
          CustomSnack.success(context, message: "Hotline Number Edited");
        }
      } catch (e) {
        CustomSnack.error(context, message: e.toString());
      }
    }
  }

  @override
  update({String? numbers, String? organizationName}) {
    state = state.copyWith(
        phoneNumber: numbers ?? state.phoneNumber,
        organizationName: organizationName ?? state.organizationName);
  }
}
