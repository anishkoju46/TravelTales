import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';
import 'package:traveltales/features/dashboard/controller/navigation_controller.dart';
import 'package:traveltales/features/profile/presentation/profile_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.watch(navigationProvider.notifier);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("${ref.watch(authNotifierProvider)?.userDetail.email}"),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         ref.read(authNotifierProvider.notifier).signOut(context);
        //       },
        //       icon: Icon(Icons.logout),
        //     ),
        //   ],
        // ),
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              final currentIndex = ref.watch(navigationProvider);
              return Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    Container(
                      //color: Colors.white,
                      child:
                          TextButton(onPressed: () {}, child: Text("Button")),
                    ),
                    Container(
                      //color: Colors.grey,
                      child: ElevatedButton(
                          onPressed: () {}, child: Text('Elevated')),
                    ),
                    Container(
                      color: Colors.white,
                    ),
                    ProfileScreen()
                  ],
                ),
              );
            }),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          indicatorShape: CircleBorder(),
          selectedIndex: ref.watch(navigationProvider),
          //labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) {
            navigationIndex.state = index;
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              label: "map",
              selectedIcon: Icon(Icons.map),
            ),
            NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: "favorite",
                selectedIcon: Icon(Icons.favorite)),
            NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                label: "Profile",
                selectedIcon: Icon(Icons.person))
          ],
        ),
      ),
    );
  }
}
