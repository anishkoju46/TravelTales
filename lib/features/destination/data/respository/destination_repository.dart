import 'package:flutter/foundation.dart';
import 'package:traveltales/features/category/domain/category_model_new.dart';
import 'package:traveltales/features/destination/domain/destination_model_new.dart';
import 'package:traveltales/utility/repository.dart';

class DestinationRepository extends Repository<DestinationModel> {
  DestinationRepository({super.token, super.client});
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

  Future<DestinationModel> addDestination(
      {required DestinationModel destination}) async {
    return await add(data: {
      "name": destination.name,
      "coordinates": destination.coordinates!.toJson(),
      "description": destination.description,
      "itinerary": destination.itinerary,
      "imageUrl": destination.imageUrl,
      "region": destination.region,
      "bestSeason": destination.bestSeason,
      "duration": destination.duration,
      "maxHeight": destination.maxHeight,
      "category": destination.category?.id,
      "emergencyContact": destination.emergencyContact,
    });
  }

  Future<DestinationModel> editDestination(
      {required DestinationModel destination}) async {
    return await updateOne(id: destination.id!, data: {
      "name": destination.name,
      "coordinates": destination.coordinates!.toJson(),
      "description": destination.description,
      "itinerary": destination.itinerary,
      "imageUrl": destination.imageUrl,
      "region": destination.region,
      "bestSeason": destination.bestSeason,
      "duration": destination.duration,
      "maxHeight": destination.maxHeight,
      "category": destination.category!.id,
      "emergencyContact": destination.emergencyContact
    });
  }

  Future<DestinationModel> delete(String id) async {
    return await removeOne(
      id: id,
    );
  }

  Future<List<DestinationModel>> searchDestination(
      {required String query}) async {
    return await search(query: query);
  }
}
