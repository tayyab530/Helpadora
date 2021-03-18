import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/registration_screen.dart';

import 'screens/login_screen.dart';

class App extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff03A9F4),
        primaryColorLight: const Color(0xff0288D1),
        primaryColorDark: const Color(0xffB3E5FC),
        accentColor: Color(0xffFFC107),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Color(0xff212121),
          ),
        ),
        textTheme: TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Helpadora',
      home: LoginScreen(),
      routes: {
        RegistrationScreen.routeName: (ctx) => RegistrationScreen(),
      },
    );
  }
}
