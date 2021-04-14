import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/login_bloc.dart';
import 'blocs/registration_bloc.dart';
import 'services/auth_services.dart';
import 'screens/main_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'services/db_firestore.dart';
import 'screens/home_loginORmain.dart';
import 'screens/write_query_screen.dart';
import 'blocs/write_query_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(
          create: (ctx) => DbFirestore(),
        ),
      ],
      child: MaterialApp(
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
        home: ChangeNotifierProvider(
            create: (context) => LoginBloc(), child: Home()),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegistrationScreen.routeName: (ctx) => ChangeNotifierProvider(
              create: (ctx) => RegistrationBloc(), child: RegistrationScreen()),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          WriteQuery.routeName: (ctx) => ChangeNotifierProvider(
                create: (ctx) => WriteQueryBloc(),
                child: WriteQuery(),
              ),
        },
      ),
    );
  }
}
