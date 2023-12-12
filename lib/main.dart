import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/widgets/login_screen.dart';
import 'package:traveltales/utility/loader.dart';

void main() {
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
    final theme = ThemeData.from(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,

        //Primary
        primary: Colors.purple, //[Filled Button]
        onPrimary: Colors.white,
        primaryContainer: Colors.white, //[Floating action button]
        onPrimaryContainer: Colors.grey,

        //Secondary
        secondary: Colors.cyan,
        onSecondary: Colors.black,
        secondaryContainer: Colors.white, //[selected kura ko BG]
        onSecondaryContainer: Color(0xffD4A056), //[select kura]

        //Error
        error:
            Colors.red, //[Badge ko lagi] aka stack wala notification vako wala
        onError: Colors.white, //[Bagde vitra ko lagi]

        //Background
        background: Colors.grey, //[Scaffold]
        onBackground: Colors.blueGrey,

        //Surface
        surface: Colors
            .grey, //[BACKGROUND : ElevatedButton, AppBar, ButtomNavigation]
        onSurface: Color(0xff333C4B), //[Text, IconButton, Icon, Chip, NavIcon]

        //outline
        outline: Colors
            .blueGrey, //[kai kura ko outline, deko xna vane: On backgournd le handle garxa]

        //tertiary
        tertiary: Colors.blueAccent,
        onTertiary: Colors.blueGrey,
        tertiaryContainer: Colors.indigoAccent,
        onTertiaryContainer: Colors.pink,
      ),
    );
    return MaterialApp(
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const Loader(),
    );
  }
}
