import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

class Global {
  static bool isFirstOpen = false;
  static bool isDarkMode = false;
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));

    Global.setData('isDarkMode', false);
    //Global.setData('isDarkMode', true);
    isDarkMode = Global.getData('isDarkMode');
    IwrTheme.init(isDarkMode);
  }

  static void setData<T>(String key, T value) {
    String type = value.runtimeType.toString();

    switch (type) {
      case "String":
        _sharedPreferences?.setString(key, value as String);
        break;
      case "int":
        _sharedPreferences?.setInt(key, value as int);
        break;
      case "bool":
        _sharedPreferences?.setBool(key, value as bool);
        break;
      case "double":
        _sharedPreferences?.setDouble(key, value as double);
        break;
      case "List<String>":
        _sharedPreferences?.setStringList(key, value as List<String>);
        break;
    }
  }

  static dynamic getData<T>(String key) {
    dynamic value = _sharedPreferences?.get(key);
    return value;
  }

  static SystemUiOverlayStyle getOverlayStyle() {
    return isDarkMode
        ? SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
          )
        : SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
          );
  }
}
