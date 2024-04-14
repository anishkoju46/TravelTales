import 'package:traveltales/features/emergency_numbers/domain/emergency_number_model.dart';
import 'package:traveltales/utility/repository.dart';

class HotlineRepository extends Repository<HotlineNumbersModel> {
  HotlineRepository({super.token, super.client});

  @override
  String get endPoint => "numbers/";
  @override
  HotlineNumbersModel fromJson(String json) =>
      HotlineNumbersModel.fromRawJson(json);

  @override
  List<HotlineNumbersModel> listfromJson(String json) =>
      hotlineNumbersModelFromJson(json);

  Future<HotlineNumbersModel> addHotlineNumber(
      {required HotlineNumbersModel numbers}) async {
    return await add(data: {
      "phoneNumber": numbers.phoneNumber,
      "organizationName": numbers.organizationName,
    });
  }

  Future<HotlineNumbersModel> editHotlineNumber(
      {required HotlineNumbersModel numbers}) async {
    return await updateOne(id: numbers.id!, data: {
      "phoneNumber": numbers.phoneNumber,
      "organizationName": numbers.organizationName,
    });
  }

  Future<HotlineNumbersModel> deleteHotlineNumber(String id) async {
    return await removeOne(id: id);
  }
}
