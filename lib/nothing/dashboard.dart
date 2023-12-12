import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("${ref.watch(authNotifierProvider)?.userDetail.email}"),
            actions: [
              IconButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signOut(context);
                  },
                  icon: Icon(Icons.logout))
            ]),
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.grey,
                  ),
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) {
            print(index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.map), label: "map"),
            NavigationDestination(icon: Icon(Icons.search), label: "search"),
            NavigationDestination(icon: Icon(Icons.favorite), label: "favorite")
          ],
        ),
      ),
    );
  }
}
