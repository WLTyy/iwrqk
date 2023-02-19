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
            color: Color.fromARGB(255, 40, 40, 40),
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(backgroundColor: Color.fromARGB(255, 40, 40, 40),),
          scaffoldBackgroundColor: CupertinoColors.black,
          cardColor: CupertinoColors.darkBackgroundGray,
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
          tabBarTheme: TabBarTheme().copyWith(labelColor: Colors.black,unselectedLabelColor: Colors.grey),
          cardColor: CupertinoColors.systemGroupedBackground,
          scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
          canvasColor: CupertinoColors.white,
          shadowColor: Colors.grey,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent);
    }
  }
}