import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';
import 'package:traveltales/features/dashboard/controller/navigation_controller.dart';
import 'package:traveltales/features/dashboard/presentation/user_dashboard/widgets/user_home.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_screen.dart';
import 'package:traveltales/features/photo/presentation/photo_screen.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

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
        body: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              final currentIndex = ref.watch(navigationProvider);
              return Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    UserHome(),
                    PhotoScreen(),
                    FavouriteScreen(),
                    ProfileScreen()
                  ],
                ),
              );
            }),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
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
              icon: Icon(Icons.add_a_photo_outlined),
              label: "Photo",
              selectedIcon: Icon(Icons.add_a_photo),
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
