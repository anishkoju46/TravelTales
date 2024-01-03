import 'package:http/http.dart' as http;
import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/utility/repository.dart';

class UserRepository extends Repository<UserModel> {
  final client = http.Client();
  final apiUrl = "http://localhost:8000/";

  @override
  UserModel fromJson(String json) => UserModel.fromRawJson(json);

  @override
  List<UserModel> listFromJson(String json) => userModelFromJson(json);

  String get endPoint => "users/";
}
