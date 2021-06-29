import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'blocs/change_password_bloc.dart';
import 'notifiers/theme_data.dart';
import 'screens/chats_rating_screen.dart';
import 'screens/password_change_screen.dart';
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
      providers: _providers,
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MaterialApp(
            // debugShowMaterialGrid: true,
            theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            title: 'Helpadora',
            home: AnimatedSplashScreen(
              duration: 5,
              splash: 'assets/images/splash_screen.png',
              backgroundColor: Theme.of(context).primaryColor,
              nextScreen: Home(),
              splashTransition: SplashTransition.fadeTransition,
              animationDuration: Duration(milliseconds: 800),
            ),
            routes: _routes,
            onGenerateRoute: route,
          );
        },
      ),
    );
  }

  List<SingleChildWidget> get _providers {
    return [
      ChangeNotifierProvider(
        create: (ctx) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (ctx) => DbFirestore(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginBloc(),
      ),
      ChangeNotifierProvider(
        create: (context) => ChangePasswordBloc(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => Filters(),
      ),
      ChangeNotifierProvider(
        create: (context) => QueriesNotifier(),
      ),
    ];
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
          create: (ctx) => RegistrationBloc(),
          child: RegistrationScreen(),
        ),
    WriteQuery.routeName: (ctx) => ChangeNotifierProvider(
          create: (ctx) => WriteQueryBloc(),
          child: WriteQuery(),
        ),
    RatingScreen.routeName: (ctx) => RatingScreen(),
    ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
  };
}

//   enum PageTransitionType {
//   /// Fade Animation
//   fade,

//   /// Right to left animation
//   rightToLeft,

//   /// Left to right animation
//   leftToRight,

//   /// Top the bottom animation

//   topToBottom,

//   /// bottom the top animation

//   bottomToTop,

//   /// scale animation

//   scale,

//   /// Rotate animation

//   rotate,

//   /// Size animation

//   size,

//   /// Right to left with fading animation

//   rightToLeftWithFade,

//   /// Left to right with fading animation

//   leftToRightWithFade,

//   /// Left to right slide as if joined

//   leftToRightJoined,

//   /// Right to left slide as if joined

//   rightToLeftJoined,
// }
