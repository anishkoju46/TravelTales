import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/utility/repository.dart';

class AuthRepository extends Repository<UserModel> {
  AuthRepository({super.token, super.client});

  @override
  UserModel fromJson(String json) => UserModel.fromRawJson(json);

  @override
  List<UserModel> listfromJson(String json) => userModelFromJson(json);

  @override
  String get endPoint => "auth";

  Future<UserModel> login({String? email, String? password}) async {
    return await add(
        data: {"email": email, "password": password}, path: "/login");
  }

  Future<UserModel> signUp(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber}) async {
    return await add(data: {
      "fullName": fullName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber
    }, path: "/signup");
  }
}
