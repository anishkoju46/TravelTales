import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/User/Presentation/controller/profile_controller.dart';
import 'package:traveltales/features/User/Presentation/widgets/change_password_screen.dart';
import 'package:traveltales/features/auth/presentation/state/state.dart';
import 'package:traveltales/utility/alertBox.dart';
import 'package:traveltales/utility/custom_list_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      final user = ref.watch(authNotifierProvider);
      return Column(children: [
        //Profile Part 1
        Expanded(
          flex: 4,
          child: Container(
            color: Color(0xff798CAB),
            padding: EdgeInsets.symmetric(vertical: 5),
            alignment: Alignment.center,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "PROFILE",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      if (user != null)
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  //fit: BoxFit.cover,
                                  image: AssetImage(
                                      "${user.imageUrl!.isEmpty ? "assets/images/default2.jpeg" : user.imageUrl}")),
                              shape: BoxShape.circle,
                              color: Colors.amber,
                              border: Border.all()),
                        ),
                      Positioned(
                          bottom: 10,
                          right: 125,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Consumer(builder: (context, ref, child) {
                    final authController = ref.watch(authNotifierProvider);

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
                          "${authController?.email}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        // Text(
                        //   "${authController?.phoneNumber}",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodyLarge
                        //       ?.copyWith(fontWeight: FontWeight.w600),
                        // )
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
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customListTile(context,
                            leadingIcon: Icons.person,
                            title: "Edit Profile", onTap: () {
                          ref.read(profileProvider.notifier).edit(context);
                        }),
                        customListTile(context,
                            leadingIcon: Icons.key,
                            title: "Change Password", onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ChangePasswordScreen();
                            },
                          ));
                        }),
                        customListTile(context,
                            leadingIcon: Icons.phone,
                            title: "Emergency Contacts",
                            onTap: () {}),
                        customListTile(context,
                            leadingIcon: Icons.info,
                            title: "About Us",
                            onTap: () {}),
                        customListTile(context,
                            leadingIcon: Icons.exit_to_app,
                            title: "Sign Out",
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer, onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertBox(
                                  confirmText: "Sign Out",
                                  onPressed: () {
                                    ref
                                        .watch(authNotifierProvider.notifier)
                                        .logout(context);
                                  },
                                  title: "Sign Out?");
                            },
                          );
                        })
                        // customProfileButtons(context,
                        //     icon: Icons.person,
                        //     profileButtonText: "Edit Profile", onTap: () {
                        //   ref.read(profileProvider.notifier).edit(context);
                        // }),
                        // customProfileButtons(context,
                        //     icon: Icons.key,
                        //     profileButtonText: "Change Password", onTap: () {
                        //   Navigator.push(context, MaterialPageRoute(
                        //     builder: (context) {
                        //       return ChangePasswordScreen();
                        //     },
                        //   ));
                        //   // ref
                        //   //     .read(profileProvider.notifier)
                        //   //     .navigateToChangePasswordPage(context);
                        // }),
                        // customProfileButtons(context,
                        //     icon: Icons.phone,
                        //     profileButtonText: "Emergency Contacts",
                        //     onTap: () {}),
                        // customProfileButtons(context,
                        //     icon: Icons.info,
                        //     profileButtonText: "About Us",
                        //     onTap: () {}),
                        // customProfileButtons(context,
                        //     icon: Icons.exit_to_app,
                        //     profileButtonText: "Sign Out",
                        //     color: Theme.of(context)
                        //         .colorScheme
                        //         .secondaryContainer, onTap: () async {
                        //   await showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertBox(
                        //             confirmText: "Logout",
                        //             onPressed: () {
                        //               ref
                        //                   .watch(authNotifierProvider.notifier)
                        //                   .logout(context);
                        //             },
                        //             title: "Logout?");
                        //       });
                        // }),
                      ],
                    ),
                  ),
                  Text("Version 1.1.0")
                ],
              );
            }),
          ),
        )
      ]);
    });
  }

  // Padding customProfileButtons(BuildContext context,
  //     {required IconData icon,
  //     required String profileButtonText,
  //     Color? color,
  //     required Function onTap}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
  //     child: InkWell(
  //       onTap: () {
  //         onTap();
  //       },
  //       child: Container(
  //         padding: EdgeInsets.symmetric(vertical: 12),
  //         decoration: BoxDecoration(
  //           color: color ?? Theme.of(context).colorScheme.onBackground,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(25),
  //           ),
  //         ),
  //         alignment: Alignment.center,
  //         child: Container(
  //           //color: Colors.red,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             //mainAxisSize: MainAxisSize.min,
  //             children: [
  //               SizedBox(width: 10),
  //               Expanded(
  //                 flex: 1,
  //                 child: Icon(
  //                   icon,
  //                   color: Theme.of(context).colorScheme.onPrimary,
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 7,
  //                 child: Text(
  //                   profileButtonText,
  //                   style: TextStyle(
  //                       color: Theme.of(context).colorScheme.background),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           //  FilledButton.icon(
  //           //   onPressed: () {},
  //           //   icon: Icon(Icons.person),
  //           //   label: Text("EditProfile"),
  //           // ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
