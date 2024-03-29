import 'package:flutter/material.dart';
import '../services/storage_sharedPrefs_theme.dart';

class ThemeNotifier with ChangeNotifier {
  bool showSplash = true;
  final darkTheme = ThemeData(
    // brightness: Brightness.dark,
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
    primaryColor: Color(0xffFFC107),
    primaryColorLight: HSLColor.fromAHSL(1, 45, 1, .55).toColor(),
    primaryColorDark: const Color(0xff0288D1),
    colorScheme: ColorScheme(
      secondary: Color(0xff03A9F4),
      brightness: Brightness.light,
      primary: Color(0xff03A9F4),
      onPrimary: Color(0xff03A9F4),
      onSecondary: Color(0xffFFC107),
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.white,
      onSurface: Colors.white,
    ),
    errorColor: Color(0xffFF5959),
    dividerColor: Color(0xffBDBDBD),
  );

  final lightTheme = ThemeData(
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
    colorScheme: ColorScheme(
        secondary: Color(0xffFFC107),
        onSecondary: Colors.transparent,
        brightness: Brightness.light,
        primary: Color(0xff03A9F4),
        onPrimary: Color(0xff03A9F4),
        error: Colors.red,
        onError: Colors.red,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.transparent,
        onSurface: Colors.transparent),
    errorColor: Color(0xffFF5959),
    dividerColor: Color(0xffBDBDBD),
  );

  ThemeNotifier({this.isLight = false, this.themeData}) {
    StorageManager.readData('themeMode').then((theme) {
      var themeMode = theme ?? 'light';
      if (themeMode == 'light') {
        this.isLight = true;
        this.themeData = lightTheme;
      } else {
        print('setting dark theme');
        this.isLight = false;
        themeData = darkTheme;
      }
      StorageManager.readData('showOnboarding').then((_showOnboarding) {
        showOnboarding = _showOnboarding == null ? true : _showOnboarding;
      });

      notifyListeners();
    });
  }

  ThemeData? themeData;

  ThemeData getTheme() => lightTheme;
  bool isLight, showOnboarding = true;

  void setDarkMode() async {
    themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    isLight = false;
    notifyListeners();
  }

  void setLightMode() async {
    themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    isLight = true;
    notifyListeners();
  }

  setSplashtoFalse() {
    showSplash = false;
  }

  setShowOnboardingFalse() {
    StorageManager.saveData('showOnboarding', false);
    showOnboarding = false;
  }
}
