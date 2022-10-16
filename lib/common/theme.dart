import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IwrTheme {
  static late Color scaffoldBackColor;
  static late Color barBackColor;
  static late Color boxBackColor;
  static late Color gray;
  static late Color fontColor;
  static late Color fontColor2;
  static late Color shadowColor;
  static late Color cardBackColor;

  static void init(bool isDarkMode) {
    reload(isDarkMode);
  }

  static void reload(bool isDarkMode) {
    if (isDarkMode) {
      scaffoldBackColor = Colors.black;
      barBackColor = CupertinoColors.darkBackgroundGray.withAlpha(248);
      boxBackColor = const Color.fromARGB(255, 40, 40, 40);
      gray = Colors.grey.shade600;
      fontColor = Colors.white;
      fontColor2 = Colors.grey.shade400;
      shadowColor = Colors.black;
      cardBackColor = const Color.fromARGB(255, 50, 50, 50);
    } else {
      scaffoldBackColor = CupertinoColors.secondarySystemBackground;
      barBackColor = Colors.white.withAlpha(248);
      boxBackColor = CupertinoColors.white;
      gray = Colors.grey;
      fontColor = Colors.black;
      fontColor2 = Colors.grey;
      shadowColor = Colors.grey;
      cardBackColor = Colors.white;
    }
  }
}
