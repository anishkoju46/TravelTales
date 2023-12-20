import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Column(children: [
        //Profile Part 1
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    //color: Colors.amber,
                    child: Text(
                      "PROFILE",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "${ref.read(authNotifierProvider)?.userDetail.imageUrl}")),
                            shape: BoxShape.circle,
                            color: Colors.amber,
                            border: Border.all()),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 110,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.edit)),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Consumer(builder: (context, ref, child) {
                    final authController = ref.read(authNotifierProvider);
                    return Column(
                      children: [
                        Text(
                          "${authController?.fullName}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${authController?.userDetail.email}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${authController?.userDetail.phoneNumber}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        )
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
          // Positioned(
          //   top: 10,
          //   left: 10,
          //   child: Container(
          //     decoration: BoxDecoration(
          //         color: Color(0xff333C4B),
          //         borderRadius: BorderRadius.all(Radius.circular(15))),
          //     child: IconButton(
          //         onPressed: () {},
          //         icon: Icon(
          //           Icons.arrow_back,
          //           color: Colors.white,
          //         )),
          //   ),
          // ),
        ),
        //Profile Part 2
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              //color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: Consumer(builder: (context, ref, child) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // customProfileButtons(context,
                          //     icon: Icons.person, profileButtonText: "Edit Profile"),
                          // customProfileButtons(context,
                          //     icon: Icons.key,
                          //     profileButtonText: "Emergency Contacts"),
                          // customProfileButtons(context,
                          //     icon: Icons.phone,
                          //     profileButtonText: "Emergency Contacts"),
                          // customProfileButtons(context,
                          //     icon: Icons.info, profileButtonText: "About Us"),
                          // customProfileButtons(context,
                          //     icon: Icons.logout,
                          //     profileButtonText: "Sign Out",
                          //     color: Color(0xffD4A056))

                          // Text("Edit Profile"),
                          // Text("Change Password"),
                          // GestureDetector(
                          //     onTap: () {
                          //       ref
                          //           .read(authNotifierProvider.notifier)
                          //           .signOut(context);
                          //     },
                          //     child: Text("SignOut"))

                          FilledButton.icon(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context).colorScheme.primary),
                            ),
                            onPressed: () {
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .signOut(context);
                            },
                            icon: (Icon(
                              Icons.person,
                              color: Colors.red,
                            )),
                            label: Text(
                              "Logout",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("Version 1.1.0")
                  ],
                ),
              );
            }),
          ),
        )
      ]);
    });
  }

  Padding customProfileButtons(BuildContext context,
      {required IconData icon,
      required String profileButtonText,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            //color: Colors.red,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon),
                Text(
                  profileButtonText,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background),
                ),
              ],
            ),
            //  FilledButton.icon(
            //   onPressed: () {},
            //   icon: Icon(Icons.person),
            //   label: Text("EditProfile"),
            // ),
          ),
        ),
      ),
    );
  }
}
