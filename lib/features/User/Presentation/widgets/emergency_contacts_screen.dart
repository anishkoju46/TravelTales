import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/utility/custom_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsScreen extends ConsumerWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Emergency Contacts",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              customListTile(context,
                  leadingIcon: Icons.phone,
                  title: "Nepal Police",
                  subtitle: "9843288795", onTap: () {
                dial("9843288795");
              },
                  TextColor: Theme.of(context).colorScheme.onBackground,
                  borderColor: Theme.of(context).colorScheme.onBackground,
                  color: Colors.white),
              customListTile(context,
                  leadingIcon: Icons.phone,
                  title: "Tourism Crisis Unit",
                  subtitle: "9751044088", onTap: () {
                dial("9751044088");
              },
                  TextColor: Theme.of(context).colorScheme.onBackground,
                  borderColor: Theme.of(context).colorScheme.onBackground,
                  color: Colors.white),
              customListTile(context,
                  leadingIcon: Icons.phone,
                  title: "Nepal Tourism Board",
                  subtitle: "4256909", onTap: () {
                dial("4256909");
              },
                  TextColor: Theme.of(context).colorScheme.onBackground,
                  borderColor: Theme.of(context).colorScheme.onBackground,
                  color: Colors.white),
              customListTile(context,
                  leadingIcon: Icons.phone,
                  title: "Nepal Police",
                  subtitle: "9843288795", onTap: () {
                dial("9843288795");
              },
                  TextColor: Theme.of(context).colorScheme.onBackground,
                  borderColor: Theme.of(context).colorScheme.onBackground,
                  color: Colors.white),
            ],
          ),
        ),
      ),
    ));
  }
}

Future<void> dial(String phoneNumber) async {
  final String phoneNumberWithCountryCode = phoneNumber;
  // "+977$phoneNumber";
  final Uri phoneLaunchUri =
      Uri(scheme: 'tel', path: phoneNumberWithCountryCode);
  if (await canLaunchUrl(phoneLaunchUri)) {
    await launchUrl(phoneLaunchUri);
  } else {
    throw 'Could not launch $phoneLaunchUri';
  }
}
