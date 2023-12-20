import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';

//locally store vako kura yeta bata

class LocalAuthRepository extends AuthRepository {
  @override
  UserModel fetchUser({required String userId}) {
    // TODO: implement fetchUser
    throw UnimplementedError();
  }

  @override
  UserModel signIn({required String email, required String pasword}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
