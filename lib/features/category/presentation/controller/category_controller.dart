import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/category/domain/category_model.dart';
import 'package:traveltales/features/destination/presentation/controller/destination_controller.dart';

final CategoryNotifierProvider =
    NotifierProvider<CategoryController, CategoryModel>(CategoryController.new);

class CategoryController extends Notifier<CategoryModel> {
  @override
  CategoryModel build() {
    return categories.first;
  }

  final List<CategoryModel> categories = [
    CategoryModel(name: "All", id: "1"),
    CategoryModel(name: "Easy", id: "2"),
    CategoryModel(name: "Moderate", id: "3"),
    CategoryModel(name: "Challenging", id: "4"),
    CategoryModel(name: "Top Rated", id: "5"),
  ];

  selectCategory(CategoryModel category) {
    state = category;
    // ref.read(destinationNotifierProvider.notifier).showByCategory();
  }

  List<CategoryModel> get usableCategories => [...categories].sublist(1, 4);
  //categories..removeWhere((element) => element.id == "1");
}
