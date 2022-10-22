import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IwrTheme {
  static late Color backColor;
  static late Color backColor2;
  static late Color backColor3;
  static late Color backColor4;
  static late Color gray;
  static late Color fontColor;
  static late Color fontColor2;
  static late Color fontColor3;
  static late Color shadowColor;
  static late Color searchBarBackColor;

  static void init(bool isDarkMode) {
    reload(isDarkMode);
  }

  static void reload(bool isDarkMode) {
    if (isDarkMode) {
      backColor = Colors.black;
      backColor2 = CupertinoColors.darkBackgroundGray.withAlpha(252);
      backColor3 = const Color.fromARGB(255, 40, 40, 40);
      backColor4 = const Color.fromARGB(255, 50, 50, 50);
      gray = Colors.grey.shade600;
      fontColor = Colors.white;
      fontColor2 = Colors.grey.shade400;
      fontColor3 = Colors.black;
      shadowColor = Colors.black;
      searchBarBackColor = const Color.fromARGB(255, 50, 50, 50);
    } else {
      backColor = CupertinoColors.secondarySystemBackground;
      backColor2 = Colors.white.withAlpha(252);
      backColor3 = CupertinoColors.white;
      backColor4 = Colors.white;
      gray = Colors.grey;
      fontColor = Colors.black;
      fontColor2 = Colors.grey;
      fontColor3 = Colors.grey.shade700;
      shadowColor = Colors.grey;
      searchBarBackColor = const Color.fromARGB(255, 250, 250, 250);
    }
  }
}
