import 'package:traveltales/features/User/Domain/user_model.dart';
import 'package:traveltales/features/auth/data/repository/auth_repository.dart';
import 'package:traveltales/features/auth/data/repository/local_auth_repository.dart';

class AuthService {
  late AuthRepository authRepository;

  UserModel login({AuthRepository? authRepository}) {
    //authRepository = RemoteAuthRepository();
    authRepository = LocalAuthRepository();
    return authRepository.fetchUser(userId: "1");
  }
}
