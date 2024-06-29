import 'dart:ui';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider() : _themeMode = _getSystemThemeMode() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = _handlePlatformBrightnessChange;
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  static ThemeMode _getSystemThemeMode() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    return brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
  }

  void _handlePlatformBrightnessChange() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    _themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
