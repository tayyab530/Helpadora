import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/points_screen.dart';
import 'package:helpadora/src/screens/query_write_screen.dart';

import 'screens/main_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';

class App extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.w200,
          ),
        ),
        primaryColor: Color(0xff03A9F4),
        primaryColorLight: const Color(0xff0288D1),
        primaryColorDark: const Color(0xffB3E5FC),
        accentColor: Color(0xffFFC107),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xff212121),
          ),
        ),
        accentTextTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xff757575),
          ),
        ),
        errorColor: Color(0xffFF5959),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Helpadora',
      home: LoginScreen(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
      },
    );
  }
}
