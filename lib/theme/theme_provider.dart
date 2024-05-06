import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightMode; // Default to light mode

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == lightMode ? darkMode : lightMode;
    notifyListeners();
  }
}
