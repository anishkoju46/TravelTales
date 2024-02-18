import 'package:http/src/client.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';

import 'package:traveltales/utility/repository.dart';

class UserRepository extends Repository<UserModel> {
  UserRepository({super.token});
  // final client = http.Client();
  // final apiUrl = "http://localhost:8000/";

  @override
  UserModel fromJson(String json) => UserModel.fromRawJson(json);

  @override
  List<UserModel> listfromJson(String json) => userModelFromJson(json);

  @override
  String get endPoint => "users/";

  Future<UserModel> editProfile(
      {required String fullName,
      required String email,
      required String phoneNumber}) async {
    return await updateOne(data: {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber
    });
  }

  @override
  Future<UserModel> fetchOne({Client? client, required String id}) {
    // TODO: implement fetchOne
    return super.fetchOne(id: id);
  }

  Future<UserModel> delete(String id) async {
    return await removeOne(
      id: id,
    );
  }

  Future<UserModel> addToFavourites({required String id}) async {
    return await addToFavourite(id: id);
  }
}
