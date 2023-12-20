import 'package:traveltales/features/User/Domain/user_model.dart';

abstract class AuthRepository {
  UserModel fetchUser({required String userId});

  UserModel signIn({required String email, required String pasword});
}
