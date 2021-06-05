import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:helpadora/src/screens/chats_rating_screen.dart';
import 'package:helpadora/src/screens/password_change_screen.dart';
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
    // debugPaintSizeEnabled = true;
    // debugPaintLayerBordersEnabled = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DbFirestore(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        // debugShowMaterialGrid: true,
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
          primaryColorLight: const Color(0xffB3E5FC),
          primaryColorDark: const Color(0xff0288D1),
          accentColor: Color(0xffFFC107),
          primaryTextTheme: TextTheme(
            headline1: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff212121),
            ),
          ),
          accentTextTheme: TextTheme(
            headline2: TextStyle(
              color: Color(0xff757575),
              fontWeight: FontWeight.normal,
            ),
          ),
          errorColor: Color(0xffFF5959),
          dividerColor: Color(0xffBDBDBD),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Helpadora',
        home: ChangeNotifierProvider(
            create: (context) => LoginBloc(), child: Home()),
        routes: _routes,
        onGenerateRoute: route,
      ),
    );
  }

  Route route(RouteSettings settings) {
    var routeName = settings.name;
    dynamic args = settings.arguments;
    print(args['queryDetails'].id);
    print(args['chatMembers'].toString());
    if (routeName == ChatScreen.routeName)
      return MaterialPageRoute(
        builder: (context) {
          return ChatScreen(args);
        },
      );
    else
      return MaterialPageRoute(
        builder: (context) => ChatScreen(args),
      );
  }

  final _routes = {
    MainScreen.routeName: (ctx) => MainScreen(),
    LoginScreen.routeName: (ctx) => LoginScreen(),
    RegistrationScreen.routeName: (ctx) => ChangeNotifierProvider(
        create: (ctx) => RegistrationBloc(), child: RegistrationScreen()),
    WriteQuery.routeName: (ctx) => ChangeNotifierProvider(
          create: (ctx) => WriteQueryBloc(),
          child: WriteQuery(),
        ),
    RatingScreen.routeName: (ctx) => RatingScreen(),
    ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
  };
}
