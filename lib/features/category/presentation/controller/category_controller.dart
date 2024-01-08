import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/category/presentation/controller/category_async_list_controller.dart';

final CategoryNotifierProvider =
    NotifierProvider<CategoryController, CategoryModel?>(
        CategoryController.new);

class CategoryController extends Notifier<CategoryModel?> {
  // List<CategoryModel> get categories => ref.watch(categoryListProvider);

  @override
  CategoryModel? build() {
    return null;
  }

  // final List<CategoryModel> categories = [
  //   CategoryModel(name: "All", id: "1"),
  //   CategoryModel(name: "Easy", id: "2"),
  //   CategoryModel(name: "Moderate", id: "3"),
  //   CategoryModel(name: "Challenging", id: "4"),
  //   CategoryModel(name: "Top Rated", id: "5"),
  // ];

  selectCategory(CategoryModel category) {
    state = category;
    // return ref.refresh(categoryListProvider);
  }

  List<CategoryModel> get usableCategories => [];
  //categories..removeWhere((element) => element.id == "1");
}
