import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/utility/repository.dart';

class CategoryRepository extends Repository<CategoryModel> {
  CategoryRepository({super.token, super.client});
  @override
  String get endPoint => "categories";

  @override
  CategoryModel fromJson(String json) => CategoryModel.fromRawJson(json);

  @override
  List<CategoryModel> listfromJson(String json) => categoryModelFromJson(json);
}
