import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        customProfileButtons(context,
            icon: Icons.exit_to_app,
            profileButtonText: "Sign Out",
            color: Color(0xffD4A056), onTap: () {
          ref.read(authNotifierProvider.notifier).signOut(context);
        }),
      ],
    );
  }

  Padding customProfileButtons(BuildContext context,
      {required IconData icon,
      required String profileButtonText,
      Color? color,
      required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: InkWell(
        onTap: () {
          onTap();
        },
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
