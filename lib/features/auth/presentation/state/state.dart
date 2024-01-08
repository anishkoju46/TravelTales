import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/auth/presentation/controller/login_controller.dart';
import 'package:traveltales/features/auth/presentation/controller/sign_controller.dart';

final authNotifierProvider =
    NotifierProvider<AuthController, UserModel?>(AuthController.new);

final loginNotifierProvider = NotifierProvider.autoDispose<LoginController,
    ({String email, String password, bool showPassword})>(LoginController.new);

final signUpNotifierProvider = NotifierProvider.autoDispose<
    SignUpController,
    ({
      String fullName,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword,
      bool showPassword,
      bool showConfirmPassword
    })>(SignUpController.new);
