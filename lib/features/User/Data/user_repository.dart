import 'package:http/http.dart' as http;
import 'package:traveltales/features/User/Domain/user_model_new.dart';

import 'package:traveltales/utility/repository.dart';

class UserRepository extends Repository<UserModel> {
  final client = http.Client();
  final apiUrl = "http://localhost:8000/";

  @override
  String get endPoint => "users/";

  @override
  UserModel fromJson(String json) => UserModel.fromRawJson(json);

  @override
  List<UserModel> listfromJson(String json) => userModelFromJson(json);
}
