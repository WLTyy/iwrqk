import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

enum IwrThemeMode { system, light, dark }

class ThemeModeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.values[Global.getData('ThemeMode')];

  ThemeMode get themeMode => _themeMode;

  void changeThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    Global.setData('ThemeMode', themeMode.index);
    notifyListeners();
  }
}

class IwrAppTheme {
  static void init(IwrThemeMode type) {
    reloadTheme(type);
  }

  static void reloadTheme(IwrThemeMode type) {}

  static ThemeData getTheme({bool isDarkMode = false}) {
    if (isDarkMode) {
      return ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(255, 40, 44, 52),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
            backgroundColor: Color.fromARGB(255, 40, 44, 52),
          ),
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 31, 34, 40),
          accentColor: Colors.black,
          cardColor: const Color.fromARGB(255, 36, 39, 46),
          indicatorColor: Colors.white,
          canvasColor: const Color.fromARGB(255, 40, 44, 52),
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
          primaryColor: Colors.blue,
          tabBarTheme: TabBarTheme().copyWith(
              labelColor: Colors.black, unselectedLabelColor: Colors.grey),
          scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
          accentColor: Colors.white,
          indicatorColor: Colors.blue,
          cardColor: CupertinoColors.systemGroupedBackground,
          canvasColor: CupertinoColors.white,
          shadowColor: Colors.grey,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent);
    }
  }
}
