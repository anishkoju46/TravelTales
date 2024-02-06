import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/state/user_state.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';

class UserDetailForAdmin extends ConsumerWidget {
  const UserDetailForAdmin({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authNotifierProvider);
    final smth = ref.watch(userListProvider);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Text("User's Name: "),
              //Text(userController)
            ],
          )
        ],
      ),
    ));
  }
}
