import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

List<({IconData icons, int size})> iconRecord = [(icons: Icons.home, size: 33)];

int currentPage = 0;
Widget customNavigationBar(
    {Function? onPressed, required bool isSelected, required index}) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(),
      ),
    ),
    child: Consumer(builder: (context, ref, child) {
      //final userService = ref.watch(userServiceProvider);
      return BottomNavigationBar(
        currentIndex: 1,
        onTap: (value) {
          //yesma currentIndex ko value tap garda ako value rakhnuparxa
          // currentPage = index;
          //ref.read(userService.navigationIndexProvider.notifier).state = index;
        },
        selectedItemColor: isSelected ? Colors.black : null,
        backgroundColor: const Color(0xffF7F9F4),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 33,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline_rounded,
                size: 33,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 33,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: 33,
              ),
              label: ""),
        ],
      );
    }),
  );
}
