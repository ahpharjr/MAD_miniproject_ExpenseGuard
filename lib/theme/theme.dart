import 'package:flutter/material.dart';

final lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      background: Color.fromARGB(255, 242, 242, 242),
      primary: Color.fromARGB(255, 238, 238, 238),
      secondary: Color.fromARGB(255, 3, 3, 3),
      tertiary: Color.fromARGB(255, 203, 203, 203),
    ));

final darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 24, 24, 24),
      primary: Color.fromARGB(255, 39, 39, 39),
      secondary: Color.fromARGB(255, 255, 255, 255),
      tertiary: Color.fromARGB(255, 48, 48, 48),
    ));
