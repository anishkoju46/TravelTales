import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer(builder: (context, ref, child) {
        return Column(children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Text("PROFILE"),
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
                  Spacer(),
                  Expanded(
                    flex: 3,
                    child: Consumer(builder: (context, ref, child) {
                      final authController = ref.read(authNotifierProvider);
                      return Column(
                        children: [
                          Text("${authController?.fullName}"),
                          Text("${authController?.userDetail.email}"),
                          Text("${authController?.userDetail.phoneNumber}")
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Consumer(builder: (context, ref, child) {
                return Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Edit Profile"),
                    Text("Change Password"),
                    GestureDetector(
                        onTap: () {
                          ref
                              .read(authNotifierProvider.notifier)
                              .signOut(context);
                        },
                        child: Text("SignOut"))
                  ],
                );
              }),
            ),
          )
        ]);
      }),
    ));
  }
}
