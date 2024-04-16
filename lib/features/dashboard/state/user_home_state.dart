import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';
import 'package:traveltales/features/dashboard/controller/user_home_controller.dart';

final userHomeProvider = NotifierProvider(UserHomeController.new);
