import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

enum IwrThemeMode { light, dark, system }

class ThemeModeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.values[Global.getData('ThemeMode')];

  ThemeMode get themeMode => _themeMode;

  void changeThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    Global.setData('ThemeMode', themeMode.index);
    notifyListeners();
  }
}

class IwrTheme {
  static void init(IwrThemeMode type) {
    reloadTheme(type);
  }

  static void reloadTheme(IwrThemeMode type) {}

  static ThemeData getTheme({bool isDarkMode = false}) {
    if (isDarkMode) {
      return ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: CupertinoColors.darkBackgroundGray,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: CupertinoColors.darkBackgroundGray),
          backgroundColor: CupertinoColors.black,
          scaffoldBackgroundColor: CupertinoColors.black,
          canvasColor: const Color.fromARGB(255, 40, 40, 40),
          shadowColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent);
    } else {
      return ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            color: CupertinoColors.white,
            foregroundColor: Colors.black,
            shadowColor: Colors.transparent,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: CupertinoColors.white),
          scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
          backgroundColor: CupertinoColors.white,
          canvasColor: CupertinoColors.white,
          shadowColor: Colors.grey,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent);
    }
  }
}
