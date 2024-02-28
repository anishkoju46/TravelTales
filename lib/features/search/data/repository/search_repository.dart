import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/utility/repository.dart';

class SearchRepository extends Repository<DestinationModel> {
  SearchRepository({super.token, super.client});

  @override
  String get endPoint => "destinations/";

  @override
  DestinationModel fromJson(String json) => DestinationModel.fromRawJson(json);

  @override
  List<DestinationModel> listfromJson(String json) =>
      destinationModelFromJson(json);

  Future<List<DestinationModel>> fetchByCategory({String? id}) async {
    if (id == null) {
      return await fetch();
    } else {
      return await fetch(path: "/category/", param: id);
    }
  }

  Future<List<DestinationModel>> searchDestination(
      {required String query}) async {
    return await search(query: query);
  }
}
