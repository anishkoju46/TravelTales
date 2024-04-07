import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/utility/loader.dart';
import 'package:traveltales/utility/theme_controller.dart';

void main() async {
  await GetStorage.init();
  // GetStorage().erase;
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.read(themeControllerProvider.notifier).theme;

    return MaterialApp(
      theme: themeController,
      debugShowCheckedModeBanner: false,
      home: const Loader(),
      //home: const DestinationDashboard(),
    );
  }
}
