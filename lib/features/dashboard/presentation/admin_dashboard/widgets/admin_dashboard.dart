import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/widgets/admin_profile_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/user_list.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(actions: [
        Text("Admin Dashboard"),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AdminProfileScreen();
            }));
          },
          child: Icon(Icons.person),
        )
      ]),
      body: Column(
        children: [
          Text("List of Users"),
          Expanded(child: UserList()),
        ],
      ),
    ));
  }
}
