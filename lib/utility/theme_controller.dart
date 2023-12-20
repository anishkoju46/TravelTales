import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeData>(ThemeController.new);

class ThemeController extends Notifier<ThemeData> {
  @override
  ThemeData build() {
    return theme;
  }

  final Color primaryColor = Color(0xff333C4B);
  final Color onSurface = Color(0xff333C4B);
  final Color secondaryContainer = Color(0xffD4A056);

  late final ThemeData theme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,

      //Primary
      primary: primaryColor, //[Filled Button]
      onPrimary: Colors.white,
      primaryContainer: Colors.white, //[Floating action button]
      onPrimaryContainer: Colors.white,

      //Secondary
      secondary: Colors.cyan,
      onSecondary: Colors.black,
      secondaryContainer: Color(0xffD4A056), //[selected kura ko BG]
      onSecondaryContainer: Colors.white, //[select kura]A3A3A3

      //Error
      error: Colors.red, //[Badge ko lagi] aka stack wala notification vako wala
      onError: Colors.white, //[Bagde vitra ko lagi]

      //Background
      background: Colors.white, //[Scaffold]
      onBackground: Color(0xff333C4B),

      //Surface
      surface: Colors
          .white, //[BACKGROUND : ElevatedButton, AppBar, ButtomNavigation]
      onSurface:
          onSurface, //[Text, IconButton, Icon, Chip, NavIcon]D4A056 // Greyish D9D9D9

      //outline
      outline: Color(
          0xff333C4B), //[kai kura ko outline, deko xna vane: On backgournd le handle garxa]

      //tertiary
      tertiary: Colors.blueAccent,
      onTertiary: Colors.blueGrey,
      tertiaryContainer: Colors.indigoAccent,
      onTertiaryContainer: Colors.pink,
    ),
  );

  //final ThemeData sdf = ThemeData.from(colorScheme: colorScheme).copy
}
