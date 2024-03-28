import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/widgets/profile_screen.dart';
import 'package:traveltales/features/dashboard/presentation/controller/navigation_controller.dart';
import 'package:traveltales/features/dashboard/presentation/user_dashboard/widgets/user_home.dart';
import 'package:traveltales/features/favourite/presentation/widgets/favourite_screen.dart';
import 'package:traveltales/features/photo/presentation/photo_screen.dart';
import 'package:traveltales/utility/image_test.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationIndex = ref.read(userNavigationProvider.notifier);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Consumer(builder: (context, ref, child) {
              final currentIndex = ref.watch(userNavigationProvider);
              return Expanded(
                child: IndexedStack(
                  index: currentIndex,
                  children: [
                    UserHome(),
                    PhotoScreen(),
                    // ImageTest(),
                    FavouriteScreen(),
                    ProfileScreen()
                  ],
                ),
              );
            }),
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
            // indicatorShape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            // CircleBorder(),
            selectedIndex: ref.watch(userNavigationProvider),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
                  label: "favourite",
                  selectedIcon: Icon(Icons.favorite)),
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
