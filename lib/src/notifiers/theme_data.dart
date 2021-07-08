import 'package:flutter/material.dart';
import '../services/storage_sharedPrefs_theme.dart';

class ThemeNotifier with ChangeNotifier {
  bool showSplash = true;
  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color(0xff212121),
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.w200,
        color: Color(0xff757575),
      ),
    ),
    primaryColor: const Color(0xffFFC107),
    primaryColorLight: const HSLColor.fromAHSL(1, 45, 1, .55).toColor(),
    primaryColorDark: const Color(0xff0288D1),
    accentColor: const Color(0xff03A9F4),
    errorColor: const Color(0xffFF5959),
    dividerColor: const Color(0xffBDBDBD),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color(0xff212121),
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.w200,
        color: Color(0xff757575),
      ),
    ),
    shadowColor: Colors.grey,
    primaryColor: Color(0xff03A9F4),
    primaryColorLight: const Color(0xffB3E5FC),
    primaryColorDark: const Color(0xff0288D1),
    accentColor: Color(0xffFFC107),
    errorColor: Color(0xffFF5959),
    dividerColor: Color(0xffBDBDBD),
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;
  bool isLight;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((theme) {
      var themeMode = theme ?? 'light';
      if (themeMode == 'light') {
        isLight = true;
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        isLight = false;
        _themeData = darkTheme;
      }

      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    isLight = false;
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    isLight = true;
    notifyListeners();
  }

  setSplashtoFalse() {
    showSplash = false;
  }
}
