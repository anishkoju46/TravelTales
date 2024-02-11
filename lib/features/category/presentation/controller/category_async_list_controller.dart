import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/features/category/data/repository/category_repository.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_controller.dart';
import 'package:traveltales/utility/async_list_controller.dart';
import 'package:traveltales/utility/repository.dart';

final categoryListProvider =
    AsyncNotifierProvider.autoDispose<CategoryController, List<CategoryModel>>(
        CategoryController.new);

class CategoryController extends AsyncListController<CategoryModel> {
  @override
  Widget formWidget(CategoryModel? model) {
    // TODO: implement formWidget
    throw UnimplementedError();
  }

  @override
  List<CategoryModel> fromStorage(String data) => categoryModelFromJson(data);

  @override
  // TODO: implement respository
  Repository<CategoryModel> get respository =>
      CategoryRepository(token: ref.watch(authNotifierProvider)!.token);

  @override
  String toStorage() => categoryModelToJson(state.value!);

  @override
  Future<List<CategoryModel>> fetchData() async {
    final categories = await super.fetchData();
    //if (categories.isNotEmpty) {
    ref
        .read(CategoryNotifierProvider.notifier)
        .selectCategory(CategoryModel(name: "All"));
    //}
    return categories;
  }

  List<CategoryModel> get usableCategories => hasData
      ? [...state.value!..removeWhere((element) => element.name == "Top Rated")]
      : [];

  @override
  bool findById(CategoryModel element, [CategoryModel? current, String? id]) {
    return element.id == ((current?.id) ?? id);
  }
}
