import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/widgets/admin_profile_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';
import 'package:traveltales/features/User/Presentation/widgets/user_list.dart';
import 'package:traveltales/features/dashboard/presentation/controller/navigation_controller.dart';
import 'package:traveltales/features/dashboard/presentation/admin_dashboard/widgets/admin_home.dart';

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.read(adminNavigationProvider.notifier);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final currentIndex = ref.watch(adminNavigationProvider);
                return Expanded(
                  child: IndexedStack(
                    index: currentIndex,
                    children: [
                      AdminHome(),
                      UserList(),
                      // Container(
                      //   color: Colors.white,
                      // ),
                      ProfileScreen()
                      //AdminProfileScreen()
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey,
              //Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: NavigationBar(
            height: 55,
            backgroundColor: Colors.transparent,
            // indicatorShape: CircleBorder(),
            selectedIndex: ref.watch(adminNavigationProvider),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (index) {
              navigationIndex.state = index;
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.landscape_outlined),
                label: "Destination",
                selectedIcon: Icon(Icons.landscape),
              ),
              NavigationDestination(
                icon: Icon(Icons.groups_outlined),
                label: "Users List",
                selectedIcon: Icon(Icons.groups),
              ),
              // NavigationDestination(
              //     icon: Icon(Icons.manage_accounts_outlined),
              //     label: "Manage",
              //     selectedIcon: Icon(Icons.manage_accounts)),
              NavigationDestination(
                  icon: Icon(Icons.person_2_outlined),
                  label: "Profile",
                  selectedIcon: Icon(Icons.person))
            ],
          ),
        ),
      ),
    );
  }
}

// appBar: AppBar(actions: [
//         Text("Admin Dashboard"),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return AdminProfileScreen();
//             }));
//           },
//           child: Icon(Icons.person),
//         )
//       ]),
