import 'package:flutter/material.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/emergency_numbers/data/emergency_number_repository.dart';
import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/features/emergency_numbers/presentation/widget/emergency_form.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/custom_snack.dart';
import 'package:traveltales/utility/repository.dart';

class HotlineNumberAsyncController
    extends AsyncListController<HotlineNumbersModel> {
  @override
  bool findById(HotlineNumbersModel element,
      [HotlineNumbersModel? current, String? id]) {
    return element.id == (current?.id ?? id);
  }

  @override
  Widget formWidget(HotlineNumbersModel? model) {
    return HotlineNumberForm(
      hotlineNumber: model,
    );
  }

  @override
  List<HotlineNumbersModel> fromStorage(String data) =>
      hotlineNumbersModelFromJson(data);

  @override
  Repository<HotlineNumbersModel> get respository => HotlineRepository(
        token: ref.read(authNotifierProvider)?.token,
      );

  @override
  String toStorage() => hotlineNumbersModelToJson(state.value!);

  deleteHotlineNumber(
      BuildContext context, HotlineNumbersModel hotlineNumber) async {
    try {
      await HotlineRepository(
        token: ref.read(authNotifierProvider)?.token,
      ).deleteHotlineNumber(hotlineNumber.id!);
      CustomSnack.error(context,
          message: "Hotline Number Deleted Successfully");
    } catch (e) {
      CustomSnack.error(context, message: e.toString());
    }
  }
}
