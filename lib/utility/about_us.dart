import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "About Us",
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    ));
  }
}
