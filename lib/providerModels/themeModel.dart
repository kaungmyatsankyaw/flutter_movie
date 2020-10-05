import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  bool _isDark = true;

  // ThemeNotifier(this._themeData);
  ThemeNotifier();

  getTheme() => _themeData;

  getIsDark() => _isDark;

  setIsDark(bool isDark) {
    _isDark = isDark;
    notifyListeners();
  }

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }
}
