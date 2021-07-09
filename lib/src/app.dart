import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/repositories/repository.dart';
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
        builder: (themeContext, theme, _) {
          Provider.of<Repository>(themeContext, listen: false).init();

          return MaterialApp(
            // debugShowMaterialGrid: true,
            theme: theme.getTheme(),
            debugShowCheckedModeBanner: false,
            title: 'Helpadora',
            home: theme.showSplash
                ? AnimatedSplashScreen(
                    splashIconSize: double.infinity,
                    nextScreen: Home(),
                    backgroundColor: Theme.of(context).primaryColor,
                    splashTransition: SplashTransition.fadeTransition,
                    splash: Image.asset('assets/images/Frame.png'),
                    animationDuration: Duration(seconds: 1),
                  )
                : Home(),
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
        create: (context) => Filters(),
      ),
      ChangeNotifierProvider(
        create: (context) => QueriesNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => Repository(),
      ),
    ];
  }

  Route route(RouteSettings settings) {
    var routeName = settings.name;
    dynamic args = settings.arguments;
    print(args['queryDetails'].qid);
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

class SplashLogo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6812864, size.height * 0.5423028);
    path_0.cubicTo(
        size.width * 0.6528779,
        size.height * 0.5631912,
        size.width * 0.6182535,
        size.height * 0.5866295,
        size.width * 0.5916197,
        size.height * 0.5979004);
    path_0.cubicTo(
        size.width * 0.5207746,
        size.height * 0.6275020,
        size.width * 0.3998577,
        size.height * 0.6452351,
        size.width * 0.2839131,
        size.height * 0.6431315);
    path_0.cubicTo(
        size.width * 0.2800070,
        size.height * 0.6429801,
        size.width * 0.2761009,
        size.height * 0.6431315,
        size.width * 0.2723723,
        size.height * 0.6432789);
    path_0.cubicTo(
        size.width * 0.2091620,
        size.height * 0.6471873,
        size.width * 0.1621094,
        size.height * 0.6945179,
        size.width * 0.1621094,
        size.height * 0.7480120);
    path_0.lineTo(size.width * 0.1621094, size.height * 0.8644661);
    path_0.lineTo(size.width * 0.0003551136, size.height * 0.8644661);
    path_0.cubicTo(size.width * 0.0001775568, size.height * 0.8625139, 0,
        size.height * 0.8604104, 0, size.height * 0.8583068);
    path_0.lineTo(0, size.height * 0.1127016);
    path_0.cubicTo(
        0,
        size.height * 0.09451952,
        size.width * 0.008877840,
        size.height * 0.07723944,
        size.width * 0.02432526,
        size.height * 0.06461753);
    path_0.cubicTo(
        size.width * 0.05060376,
        size.height * 0.04297928,
        size.width * 0.07919014,
        size.height * 0.02314478,
        size.width * 0.1095526,
        size.height * 0.005113227);
    path_0.cubicTo(
        size.width * 0.1315695,
        size.height * -0.007959681,
        size.width * 0.1619319,
        size.height * 0.005413745,
        size.width * 0.1621094,
        size.height * 0.02825371);
    path_0.lineTo(size.width * 0.1621094, size.height * 0.4763386);
    path_0.cubicTo(
        size.width * 0.1621094,
        size.height * 0.5199124,
        size.width * 0.2096944,
        size.height * 0.5516215,
        size.width * 0.2597657,
        size.height * 0.5423028);
    path_0.cubicTo(
        size.width * 0.2617188,
        size.height * 0.5418526,
        size.width * 0.2636718,
        size.height * 0.5415538,
        size.width * 0.2656249,
        size.height * 0.5412510);
    path_0.cubicTo(
        size.width * 0.3547587,
        size.height * 0.5262271,
        size.width * 0.3904474,
        size.height * 0.5051873,
        size.width * 0.4103338,
        size.height * 0.4949721);
    path_0.cubicTo(
        size.width * 0.4334160,
        size.height * 0.4832510,
        size.width * 0.4785164,
        size.height * 0.4751355,
        size.width * 0.4699906,
        size.height * 0.4925657);
    path_0.cubicTo(
        size.width * 0.4614700,
        size.height * 0.5101474,
        size.width * 0.4122869,
        size.height * 0.5296813,
        size.width * 0.3945310,
        size.height * 0.5567291);
    path_0.cubicTo(
        size.width * 0.3945310,
        size.height * 0.5567291,
        size.width * 0.5149155,
        size.height * 0.5917410,
        size.width * 0.5926854,
        size.height * 0.5556773);
    path_0.cubicTo(
        size.width * 0.6212723,
        size.height * 0.5424542,
        size.width * 0.6422207,
        size.height * 0.5292311,
        size.width * 0.6592676,
        size.height * 0.5187131);
    path_0.cubicTo(
        size.width * 0.6775587,
        size.height * 0.5072908,
        size.width * 0.6983286,
        size.height * 0.5296813,
        size.width * 0.6812864,
        size.height * 0.5423028);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.8714507, size.height * 0.01517610);
    path_1.cubicTo(
        size.width * 0.8746432,
        size.height * 0.01517610,
        size.width * 0.8778404,
        size.height * 0.01607765,
        size.width * 0.8806808,
        size.height * 0.01773056);
    path_1.cubicTo(
        size.width * 0.9078498,
        size.height * 0.03380869,
        size.width * 0.9344836,
        size.height * 0.05214064,
        size.width * 0.9595164,
        size.height * 0.07227610);
    path_1.cubicTo(
        size.width * 0.9740751,
        size.height * 0.08384622,
        size.width * 0.9824225,
        size.height * 0.1002251,
        size.width * 0.9824225,
        size.height * 0.1170542);
    path_1.lineTo(size.width * 0.9824225, size.height * 0.8494343);
    path_1.lineTo(size.width * 0.8558263, size.height * 0.8494343);
    path_1.lineTo(size.width * 0.8558263, size.height * 0.4988725);
    path_1.cubicTo(
        size.width * 0.8558263,
        size.height * 0.4533426,
        size.width * 0.8119671,
        size.height * 0.4163785,
        size.width * 0.7581690,
        size.height * 0.4163785);
    path_1.cubicTo(
        size.width * 0.7508873,
        size.height * 0.4163785,
        size.width * 0.7436103,
        size.height * 0.4171315,
        size.width * 0.7372160,
        size.height * 0.4183307);
    path_1.cubicTo(
        size.width * 0.7349061,
        size.height * 0.4186335,
        size.width * 0.7327793,
        size.height * 0.4190837,
        size.width * 0.7304695,
        size.height * 0.4195339);
    path_1.cubicTo(
        size.width * 0.6448873,
        size.height * 0.4339602,
        size.width * 0.6058263,
        size.height * 0.4543944,
        size.width * 0.5848732,
        size.height * 0.4653625);
    path_1.lineTo(size.width * 0.5806103, size.height * 0.4676175);
    path_1.cubicTo(
        size.width * 0.5758169,
        size.height * 0.4700239,
        size.width * 0.5697793,
        size.height * 0.4722749,
        size.width * 0.5635634,
        size.height * 0.4740797);
    path_1.cubicTo(
        size.width * 0.5665822,
        size.height * 0.4719761,
        size.width * 0.5696009,
        size.height * 0.4700239,
        size.width * 0.5724413,
        size.height * 0.4680677);
    path_1.cubicTo(
        size.width * 0.5900235,
        size.height * 0.4563466,
        size.width * 0.6099061,
        size.height * 0.4429761,
        size.width * 0.6209155,
        size.height * 0.4259960);
    path_1.cubicTo(
        size.width * 0.6248216,
        size.height * 0.4201355,
        size.width * 0.6235775,
        size.height * 0.4127729,
        size.width * 0.6178967,
        size.height * 0.4081155);
    path_1.cubicTo(
        size.width * 0.6104413,
        size.height * 0.4018008,
        size.width * 0.5474085,
        size.height * 0.3884291,
        size.width * 0.4948498,
        size.height * 0.3884291);
    path_1.cubicTo(
        size.width * 0.4570315,
        size.height * 0.3884291,
        size.width * 0.4245385,
        size.height * 0.3945900,
        size.width * 0.3986150,
        size.height * 0.4066096);
    path_1.cubicTo(
        size.width * 0.3707390,
        size.height * 0.4193825,
        size.width * 0.3501423,
        size.height * 0.4321554,
        size.width * 0.3336296,
        size.height * 0.4423745);
    path_1.lineTo(size.width * 0.3295455, size.height * 0.4447769);
    path_1.cubicTo(
        size.width * 0.3664775,
        size.height * 0.4177291,
        size.width * 0.3955967,
        size.height * 0.3996972,
        size.width * 0.4160160,
        size.height * 0.3911339);
    path_1.cubicTo(
        size.width * 0.4797606,
        size.height * 0.3645375,
        size.width * 0.5901972,
        size.height * 0.3472574,
        size.width * 0.6970892,
        size.height * 0.3472574);
    path_1.cubicTo(
        size.width * 0.7031268,
        size.height * 0.3472574,
        size.width * 0.7093380,
        size.height * 0.3472574,
        size.width * 0.7157324,
        size.height * 0.3474076);
    path_1.cubicTo(
        size.width * 0.7198169,
        size.height * 0.3474076,
        size.width * 0.7242535,
        size.height * 0.3474076,
        size.width * 0.7285164,
        size.height * 0.3471068);
    path_1.cubicTo(
        size.width * 0.7995399,
        size.height * 0.3427494,
        size.width * 0.8552911,
        size.height * 0.2901574,
        size.width * 0.8552911,
        size.height * 0.2273474);
    path_1.lineTo(size.width * 0.8552911, size.height * 0.02824896);
    path_1.cubicTo(
        size.width * 0.8556479,
        size.height * 0.02013478,
        size.width * 0.8636385,
        size.height * 0.01517610,
        size.width * 0.8714507,
        size.height * 0.01517610);
    path_1.close();
    path_1.moveTo(size.width * 0.8714507, size.height * 0.0001497916);
    path_1.cubicTo(
        size.width * 0.8540469,
        size.height * 0.0001497916,
        size.width * 0.8378920,
        size.height * 0.01156976,
        size.width * 0.8378920,
        size.height * 0.02824896);
    path_1.lineTo(size.width * 0.8378920, size.height * 0.2271972);
    path_1.cubicTo(
        size.width * 0.8378920,
        size.height * 0.2806908,
        size.width * 0.7906620,
        size.height * 0.3280235,
        size.width * 0.7276291,
        size.height * 0.3319303);
    path_1.cubicTo(
        size.width * 0.7237230,
        size.height * 0.3322311,
        size.width * 0.7199953,
        size.height * 0.3322311,
        size.width * 0.7160845,
        size.height * 0.3322311);
    path_1.cubicTo(
        size.width * 0.7098732,
        size.height * 0.3320805,
        size.width * 0.7036573,
        size.height * 0.3320805,
        size.width * 0.6974413,
        size.height * 0.3320805);
    path_1.cubicTo(
        size.width * 0.5873568,
        size.height * 0.3320805,
        size.width * 0.4754977,
        size.height * 0.3495112,
        size.width * 0.4083808,
        size.height * 0.3774602);
    path_1.cubicTo(
        size.width * 0.3810371,
        size.height * 0.3888801,
        size.width * 0.3453484,
        size.height * 0.4132231,
        size.width * 0.3165840,
        size.height * 0.4344104);
    path_1.cubicTo(
        size.width * 0.3029122,
        size.height * 0.4446295,
        size.width * 0.3139207,
        size.height * 0.4608566,
        size.width * 0.3281254,
        size.height * 0.4608566);
    path_1.cubicTo(
        size.width * 0.3314986,
        size.height * 0.4608566,
        size.width * 0.3352272,
        size.height * 0.4599562,
        size.width * 0.3387784,
        size.height * 0.4577012);
    path_1.cubicTo(
        size.width * 0.3561793,
        size.height * 0.4470319,
        size.width * 0.3774859,
        size.height * 0.4333586,
        size.width * 0.4073155,
        size.height * 0.4196853);
    path_1.cubicTo(
        size.width * 0.4337714,
        size.height * 0.4073625,
        size.width * 0.4651991,
        size.height * 0.4033068,
        size.width * 0.4950282,
        size.height * 0.4033068);
    path_1.cubicTo(
        size.width * 0.5529108,
        size.height * 0.4033068,
        size.width * 0.6052911,
        size.height * 0.4184821,
        size.width * 0.6054695,
        size.height * 0.4186335);
    path_1.cubicTo(
        size.width * 0.5877136,
        size.height * 0.4456813,
        size.width * 0.5385305,
        size.height * 0.4652151,
        size.width * 0.5300094,
        size.height * 0.4827928);
    path_1.cubicTo(
        size.width * 0.5264554,
        size.height * 0.4900080,
        size.width * 0.5321362,
        size.height * 0.4928606,
        size.width * 0.5417277,
        size.height * 0.4928606);
    path_1.cubicTo(
        size.width * 0.5552207,
        size.height * 0.4928606,
        size.width * 0.5761737,
        size.height * 0.4873028,
        size.width * 0.5896667,
        size.height * 0.4803904);
    path_1.cubicTo(
        size.width * 0.6095540,
        size.height * 0.4701713,
        size.width * 0.6452394,
        size.height * 0.4491355,
        size.width * 0.7343756,
        size.height * 0.4341076);
    path_1.cubicTo(
        size.width * 0.7363286,
        size.height * 0.4336574,
        size.width * 0.7382817,
        size.height * 0.4333586,
        size.width * 0.7402347,
        size.height * 0.4330558);
    path_1.cubicTo(
        size.width * 0.7462723,
        size.height * 0.4318566,
        size.width * 0.7521315,
        size.height * 0.4314064,
        size.width * 0.7579906,
        size.height * 0.4314064);
    path_1.cubicTo(
        size.width * 0.8009577,
        size.height * 0.4314064,
        size.width * 0.8378920,
        size.height * 0.4607052,
        size.width * 0.8378920,
        size.height * 0.4988725);
    path_1.lineTo(size.width * 0.8378920, size.height * 0.8644622);
    path_1.lineTo(size.width * 0.9998216, size.height * 0.8644622);
    path_1.cubicTo(size.width, size.height * 0.8637092, size.width,
        size.height * 0.8631116, size.width, size.height * 0.8623586);
    path_1.lineTo(size.width, size.height * 0.1170542);
    path_1.cubicTo(
        size.width,
        size.height * 0.09601753,
        size.width * 0.9897042,
        size.height * 0.07573187,
        size.width * 0.9715915,
        size.height * 0.06130677);
    path_1.cubicTo(
        size.width * 0.9463803,
        size.height * 0.04102112,
        size.width * 0.9193897,
        size.height * 0.02223845,
        size.width * 0.8908028,
        size.height * 0.005409004);
    path_1.cubicTo(
        size.width * 0.8847653,
        size.height * 0.001802685,
        size.width * 0.8780188,
        size.height * 0.0001497916,
        size.width * 0.8714507,
        size.height * 0.0001497916);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.08931127, size.height * 0.9021793);
    path_2.lineTo(size.width * 0.08931127, size.height * 0.9933904);
    path_2.lineTo(size.width * 0.07404131, size.height * 0.9933904);
    path_2.lineTo(size.width * 0.07404131, size.height * 0.9531195);
    path_2.cubicTo(
        size.width * 0.07404131,
        size.height * 0.9510159,
        size.width * 0.07208826,
        size.height * 0.9493625,
        size.width * 0.06960235,
        size.height * 0.9493625);
    path_2.lineTo(size.width * 0.02414775, size.height * 0.9493625);
    path_2.cubicTo(
        size.width * 0.02166192,
        size.height * 0.9493625,
        size.width * 0.01970883,
        size.height * 0.9510159,
        size.width * 0.01970883,
        size.height * 0.9531195);
    path_2.lineTo(size.width * 0.01970883, size.height * 0.9933904);
    path_2.lineTo(size.width * 0.004438920, size.height * 0.9933904);
    path_2.lineTo(size.width * 0.004438920, size.height * 0.9021793);
    path_2.lineTo(size.width * 0.01970883, size.height * 0.9021793);
    path_2.lineTo(size.width * 0.01970883, size.height * 0.9361394);
    path_2.cubicTo(
        size.width * 0.01970883,
        size.height * 0.9382430,
        size.width * 0.02166192,
        size.height * 0.9398964,
        size.width * 0.02414775,
        size.height * 0.9398964);
    path_2.lineTo(size.width * 0.06942488, size.height * 0.9398964);
    path_2.cubicTo(
        size.width * 0.07191033,
        size.height * 0.9398964,
        size.width * 0.07386385,
        size.height * 0.9382430,
        size.width * 0.07386385,
        size.height * 0.9361394);
    path_2.lineTo(size.width * 0.07386385, size.height * 0.9021793);
    path_2.lineTo(size.width * 0.08931127, size.height * 0.9021793);
    path_2.close();
    path_2.moveTo(size.width * 0.09375023, size.height * 0.8984223);
    path_2.lineTo(size.width * 0.06960235, size.height * 0.8984223);
    path_2.lineTo(size.width * 0.06960235, size.height * 0.9361394);
    path_2.lineTo(size.width * 0.02414775, size.height * 0.9361394);
    path_2.lineTo(size.width * 0.02414775, size.height * 0.8984223);
    path_2.lineTo(0, size.height * 0.8984223);
    path_2.lineTo(0, size.height * 0.9971474);
    path_2.lineTo(size.width * 0.02414775, size.height * 0.9971474);
    path_2.lineTo(size.width * 0.02414775, size.height * 0.9531195);
    path_2.lineTo(size.width * 0.06942488, size.height * 0.9531195);
    path_2.lineTo(size.width * 0.06942488, size.height * 0.9971474);
    path_2.lineTo(size.width * 0.09357230, size.height * 0.9971474);
    path_2.lineTo(size.width * 0.09357230, size.height * 0.8984223);
    path_2.lineTo(size.width * 0.09375023, size.height * 0.8984223);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.1990418, size.height * 0.9021793);
    path_3.lineTo(size.width * 0.1990418, size.height * 0.9120956);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9120956);
    path_3.cubicTo(
        size.width * 0.1392052,
        size.height * 0.9120956,
        size.width * 0.1372516,
        size.height * 0.9137490,
        size.width * 0.1372516,
        size.height * 0.9158526);
    path_3.lineTo(size.width * 0.1372516, size.height * 0.9368884);
    path_3.cubicTo(
        size.width * 0.1372516,
        size.height * 0.9389920,
        size.width * 0.1392052,
        size.height * 0.9406454,
        size.width * 0.1416906,
        size.height * 0.9406454);
    path_3.lineTo(size.width * 0.1938925, size.height * 0.9406454);
    path_3.lineTo(size.width * 0.1938925, size.height * 0.9502629);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9502629);
    path_3.cubicTo(
        size.width * 0.1392052,
        size.height * 0.9502629,
        size.width * 0.1372516,
        size.height * 0.9519163,
        size.width * 0.1372516,
        size.height * 0.9540199);
    path_3.lineTo(size.width * 0.1372516, size.height * 0.9794143);
    path_3.cubicTo(
        size.width * 0.1372516,
        size.height * 0.9815179,
        size.width * 0.1392052,
        size.height * 0.9831713,
        size.width * 0.1416906,
        size.height * 0.9831713);
    path_3.lineTo(size.width * 0.2018826, size.height * 0.9831713);
    path_3.lineTo(size.width * 0.2018826, size.height * 0.9933904);
    path_3.lineTo(size.width * 0.1223371, size.height * 0.9933904);
    path_3.lineTo(size.width * 0.1223371, size.height * 0.9021793);
    path_3.lineTo(size.width * 0.1990418, size.height * 0.9021793);
    path_3.close();
    path_3.moveTo(size.width * 0.2034808, size.height * 0.8984223);
    path_3.lineTo(size.width * 0.1178981, size.height * 0.8984223);
    path_3.lineTo(size.width * 0.1178981, size.height * 0.9971474);
    path_3.lineTo(size.width * 0.2063216, size.height * 0.9971474);
    path_3.lineTo(size.width * 0.2063216, size.height * 0.9794143);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9794143);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9540199);
    path_3.lineTo(size.width * 0.1983315, size.height * 0.9540199);
    path_3.lineTo(size.width * 0.1983315, size.height * 0.9368884);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9368884);
    path_3.lineTo(size.width * 0.1416906, size.height * 0.9158526);
    path_3.lineTo(size.width * 0.2034808, size.height * 0.9158526);
    path_3.lineTo(size.width * 0.2034808, size.height * 0.8984223);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.2452052, size.height * 0.9021793);
    path_4.lineTo(size.width * 0.2452052, size.height * 0.9794143);
    path_4.cubicTo(
        size.width * 0.2452052,
        size.height * 0.9815179,
        size.width * 0.2471582,
        size.height * 0.9831713,
        size.width * 0.2496441,
        size.height * 0.9831713);
    path_4.lineTo(size.width * 0.3034437, size.height * 0.9831713);
    path_4.lineTo(size.width * 0.3034437, size.height * 0.9933904);
    path_4.lineTo(size.width * 0.2297577, size.height * 0.9933904);
    path_4.lineTo(size.width * 0.2297577, size.height * 0.9021793);
    path_4.lineTo(size.width * 0.2452052, size.height * 0.9021793);
    path_4.close();
    path_4.moveTo(size.width * 0.2496441, size.height * 0.8984223);
    path_4.lineTo(size.width * 0.2253188, size.height * 0.8984223);
    path_4.lineTo(size.width * 0.2253188, size.height * 0.9971474);
    path_4.lineTo(size.width * 0.3078826, size.height * 0.9971474);
    path_4.lineTo(size.width * 0.3078826, size.height * 0.9794143);
    path_4.lineTo(size.width * 0.2496441, size.height * 0.9794143);
    path_4.lineTo(size.width * 0.2496441, size.height * 0.8984223);
    path_4.close();

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_4, paint_4_fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3750005, size.height * 0.9021793);
    path_5.cubicTo(
        size.width * 0.3854765,
        size.height * 0.9021793,
        size.width * 0.3936441,
        size.height * 0.9044343,
        size.width * 0.3996808,
        size.height * 0.9089402);
    path_5.cubicTo(
        size.width * 0.4055404,
        size.height * 0.9132988,
        size.width * 0.4083812,
        size.height * 0.9202112,
        size.width * 0.4083812,
        size.height * 0.9298287);
    path_5.cubicTo(
        size.width * 0.4083812,
        size.height * 0.9401952,
        size.width * 0.4055404,
        size.height * 0.9475578,
        size.width * 0.3996808,
        size.height * 0.9516175);
    path_5.cubicTo(
        size.width * 0.3936441,
        size.height * 0.9558247,
        size.width * 0.3847662,
        size.height * 0.9579283,
        size.width * 0.3732249,
        size.height * 0.9579283);
    path_5.lineTo(size.width * 0.3488995, size.height * 0.9579283);
    path_5.cubicTo(
        size.width * 0.3464136,
        size.height * 0.9579283,
        size.width * 0.3444606,
        size.height * 0.9595817,
        size.width * 0.3444606,
        size.height * 0.9616853);
    path_5.lineTo(size.width * 0.3444606, size.height * 0.9933904);
    path_5.lineTo(size.width * 0.3291906, size.height * 0.9933904);
    path_5.lineTo(size.width * 0.3291906, size.height * 0.9021793);
    path_5.lineTo(size.width * 0.3750005, size.height * 0.9021793);
    path_5.close();
    path_5.moveTo(size.width * 0.3490770, size.height * 0.9484622);
    path_5.lineTo(size.width * 0.3710944, size.height * 0.9484622);
    path_5.cubicTo(
        size.width * 0.3778413,
        size.height * 0.9484622,
        size.width * 0.3831681,
        size.height * 0.9469562,
        size.width * 0.3870742,
        size.height * 0.9439522);
    path_5.cubicTo(
        size.width * 0.3911582,
        size.height * 0.9407968,
        size.width * 0.3931113,
        size.height * 0.9361394,
        size.width * 0.3931113,
        size.height * 0.9299801);
    path_5.cubicTo(
        size.width * 0.3931113,
        size.height * 0.9236653,
        size.width * 0.3909808,
        size.height * 0.9190080,
        size.width * 0.3868967,
        size.height * 0.9161554);
    path_5.cubicTo(
        size.width * 0.3829906,
        size.height * 0.9134502,
        size.width * 0.3776638,
        size.height * 0.9119482,
        size.width * 0.3710944,
        size.height * 0.9119482);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9119482);
    path_5.cubicTo(
        size.width * 0.3465915,
        size.height * 0.9119482,
        size.width * 0.3446380,
        size.height * 0.9135976,
        size.width * 0.3446380,
        size.height * 0.9157012);
    path_5.lineTo(size.width * 0.3446380, size.height * 0.9447052);
    path_5.cubicTo(
        size.width * 0.3446380,
        size.height * 0.9468088,
        size.width * 0.3465915,
        size.height * 0.9484622,
        size.width * 0.3490770,
        size.height * 0.9484622);
    path_5.close();
    path_5.moveTo(size.width * 0.3750005, size.height * 0.8984223);
    path_5.lineTo(size.width * 0.3249296, size.height * 0.8984223);
    path_5.lineTo(size.width * 0.3249296, size.height * 0.9971474);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9971474);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9616853);
    path_5.lineTo(size.width * 0.3734023, size.height * 0.9616853);
    path_5.cubicTo(
        size.width * 0.3860089,
        size.height * 0.9616853,
        size.width * 0.3957746,
        size.height * 0.9592789,
        size.width * 0.4026995,
        size.height * 0.9544701);
    path_5.cubicTo(
        size.width * 0.4094465,
        size.height * 0.9496614,
        size.width * 0.4129977,
        size.height * 0.9413984,
        size.width * 0.4129977,
        size.height * 0.9298287);
    path_5.cubicTo(
        size.width * 0.4129977,
        size.height * 0.9191594,
        size.width * 0.4096239,
        size.height * 0.9113466,
        size.width * 0.4026995,
        size.height * 0.9062351);
    path_5.cubicTo(
        size.width * 0.3957746,
        size.height * 0.9009761,
        size.width * 0.3865418,
        size.height * 0.8984223,
        size.width * 0.3750005,
        size.height * 0.8984223);
    path_5.close();
    path_5.moveTo(size.width * 0.3490770, size.height * 0.9447052);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9157012);
    path_5.lineTo(size.width * 0.3710944, size.height * 0.9157012);
    path_5.cubicTo(
        size.width * 0.3765986,
        size.height * 0.9157012,
        size.width * 0.3810376,
        size.height * 0.9167530,
        size.width * 0.3840559,
        size.height * 0.9190080);
    path_5.cubicTo(
        size.width * 0.3870742,
        size.height * 0.9212629,
        size.width * 0.3886723,
        size.height * 0.9248685,
        size.width * 0.3886723,
        size.height * 0.9299801);
    path_5.cubicTo(
        size.width * 0.3886723,
        size.height * 0.9350876,
        size.width * 0.3870742,
        size.height * 0.9388446,
        size.width * 0.3840559,
        size.height * 0.9412470);
    path_5.cubicTo(
        size.width * 0.3810376,
        size.height * 0.9436534,
        size.width * 0.3765986,
        size.height * 0.9448526,
        size.width * 0.3710944,
        size.height * 0.9448526);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9448526);
    path_5.lineTo(size.width * 0.3490770, size.height * 0.9447052);
    path_5.close();

    Paint paint_5_fill = Paint()..style = PaintingStyle.fill;
    paint_5_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_5, paint_5_fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4538347, size.height * 0.8984223);
    path_6.lineTo(size.width * 0.4813568, size.height * 0.8984223);
    path_6.lineTo(size.width * 0.5225493, size.height * 0.9971474);
    path_6.lineTo(size.width * 0.4960939, size.height * 0.9971474);
    path_6.lineTo(size.width * 0.4884601, size.height * 0.9768606);
    path_6.lineTo(size.width * 0.4456671, size.height * 0.9768606);
    path_6.lineTo(size.width * 0.4376770, size.height * 0.9971474);
    path_6.lineTo(size.width * 0.4121089, size.height * 0.9971474);
    path_6.lineTo(size.width * 0.4538347, size.height * 0.8984223);
    path_6.close();
    path_6.moveTo(size.width * 0.4522366, size.height * 0.9598805);
    path_6.lineTo(size.width * 0.4820657, size.height * 0.9598805);
    path_6.lineTo(size.width * 0.4673291, size.height * 0.9209641);
    path_6.lineTo(size.width * 0.4522366, size.height * 0.9598805);
    path_6.close();

    Paint paint_6_fill = Paint()..style = PaintingStyle.fill;
    paint_6_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_6, paint_6_fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.6060000, size.height * 0.9006773);
    path_7.cubicTo(
        size.width * 0.6141690,
        size.height * 0.9029323,
        size.width * 0.6207371,
        size.height * 0.9071394,
        size.width * 0.6258873,
        size.height * 0.9131474);
    path_7.cubicTo(
        size.width * 0.6299718,
        size.height * 0.9181076,
        size.width * 0.6326338,
        size.height * 0.9233665,
        size.width * 0.6342347,
        size.height * 0.9290757);
    path_7.cubicTo(
        size.width * 0.6356526,
        size.height * 0.9347888,
        size.width * 0.6363662,
        size.height * 0.9401952,
        size.width * 0.6363662,
        size.height * 0.9454542);
    path_7.cubicTo(
        size.width * 0.6363662,
        size.height * 0.9585299,
        size.width * 0.6331690,
        size.height * 0.9696494,
        size.width * 0.6269531,
        size.height * 0.9788127);
    path_7.cubicTo(
        size.width * 0.6184319,
        size.height * 0.9911355,
        size.width * 0.6054695,
        size.height * 0.9972948,
        size.width * 0.5878920,
        size.height * 0.9972948);
    path_7.lineTo(size.width * 0.5376432, size.height * 0.9972948);
    path_7.lineTo(size.width * 0.5376432, size.height * 0.8985737);
    path_7.lineTo(size.width * 0.5878920, size.height * 0.8985737);
    path_7.cubicTo(
        size.width * 0.5951690,
        size.height * 0.8985737,
        size.width * 0.6012066,
        size.height * 0.8993267,
        size.width * 0.6060000,
        size.height * 0.9006773);
    path_7.close();
    path_7.moveTo(size.width * 0.5612582, size.height * 0.9155538);
    path_7.lineTo(size.width * 0.5612582, size.height * 0.9800159);
    path_7.lineTo(size.width * 0.5838075, size.height * 0.9800159);
    path_7.cubicTo(
        size.width * 0.5953474,
        size.height * 0.9800159,
        size.width * 0.6033380,
        size.height * 0.9752072,
        size.width * 0.6079531,
        size.height * 0.9655896);
    path_7.cubicTo(
        size.width * 0.6104413,
        size.height * 0.9603307,
        size.width * 0.6116854,
        size.height * 0.9540199,
        size.width * 0.6116854,
        size.height * 0.9468088);
    path_7.cubicTo(
        size.width * 0.6116854,
        size.height * 0.9367410,
        size.width * 0.6097324,
        size.height * 0.9290757,
        size.width * 0.6061784,
        size.height * 0.9236693);
    path_7.cubicTo(
        size.width * 0.6024507,
        size.height * 0.9182590,
        size.width * 0.5949953,
        size.height * 0.9155538,
        size.width * 0.5839859,
        size.height * 0.9155538);
    path_7.lineTo(size.width * 0.5612582, size.height * 0.9155538);
    path_7.close();

    Paint paint_7_fill = Paint()..style = PaintingStyle.fill;
    paint_7_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_7, paint_7_fill);

    Path path_8 = Path();
    path_8.moveTo(size.width * 0.7444977, size.height * 0.9884303);
    path_8.cubicTo(
        size.width * 0.7356197,
        size.height * 0.9960956,
        size.width * 0.7230094,
        size.height,
        size.width * 0.7063192,
        size.height);
    path_8.cubicTo(
        size.width * 0.6896291,
        size.height,
        size.width * 0.6768451,
        size.height * 0.9960956,
        size.width * 0.6681455,
        size.height * 0.9884303);
    path_8.cubicTo(
        size.width * 0.6562488,
        size.height * 0.9789641,
        size.width * 0.6503897,
        size.height * 0.9654422,
        size.width * 0.6503897,
        size.height * 0.9477092);
    path_8.cubicTo(
        size.width * 0.6503897,
        size.height * 0.9296773,
        size.width * 0.6562488,
        size.height * 0.9160040,
        size.width * 0.6681455,
        size.height * 0.9069880);
    path_8.cubicTo(
        size.width * 0.6770235,
        size.height * 0.8993267,
        size.width * 0.6896291,
        size.height * 0.8954183,
        size.width * 0.7063192,
        size.height * 0.8954183);
    path_8.cubicTo(
        size.width * 0.7230094,
        size.height * 0.8954183,
        size.width * 0.7357934,
        size.height * 0.8993267,
        size.width * 0.7444977,
        size.height * 0.9069880);
    path_8.cubicTo(
        size.width * 0.7562160,
        size.height * 0.9160040,
        size.width * 0.7620751,
        size.height * 0.9296773,
        size.width * 0.7620751,
        size.height * 0.9477092);
    path_8.cubicTo(
        size.width * 0.7620751,
        size.height * 0.9654422,
        size.width * 0.7562160,
        size.height * 0.9789641,
        size.width * 0.7444977,
        size.height * 0.9884303);
    path_8.close();
    path_8.moveTo(size.width * 0.7292254, size.height * 0.9734064);
    path_8.cubicTo(
        size.width * 0.7349061,
        size.height * 0.9673944,
        size.width * 0.7377465,
        size.height * 0.9588287,
        size.width * 0.7377465,
        size.height * 0.9477092);
    path_8.cubicTo(
        size.width * 0.7377465,
        size.height * 0.9365896,
        size.width * 0.7349061,
        size.height * 0.9280239,
        size.width * 0.7292254,
        size.height * 0.9220159);
    path_8.cubicTo(
        size.width * 0.7235446,
        size.height * 0.9160040,
        size.width * 0.7159108,
        size.height * 0.9130000,
        size.width * 0.7063192,
        size.height * 0.9130000);
    path_8.cubicTo(
        size.width * 0.6967324,
        size.height * 0.9130000,
        size.width * 0.6889202,
        size.height * 0.9160040,
        size.width * 0.6832394,
        size.height * 0.9220159);
    path_8.cubicTo(
        size.width * 0.6775587,
        size.height * 0.9280239,
        size.width * 0.6745399,
        size.height * 0.9365896,
        size.width * 0.6745399,
        size.height * 0.9477092);
    path_8.cubicTo(
        size.width * 0.6745399,
        size.height * 0.9588287,
        size.width * 0.6773803,
        size.height * 0.9673944,
        size.width * 0.6832394,
        size.height * 0.9734064);
    path_8.cubicTo(
        size.width * 0.6889202,
        size.height * 0.9794143,
        size.width * 0.6967324,
        size.height * 0.9824223,
        size.width * 0.7063192,
        size.height * 0.9824223);
    path_8.cubicTo(
        size.width * 0.7159108,
        size.height * 0.9824223,
        size.width * 0.7235446,
        size.height * 0.9794143,
        size.width * 0.7292254,
        size.height * 0.9734064);
    path_8.close();

    Paint paint_8_fill = Paint()..style = PaintingStyle.fill;
    paint_8_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_8, paint_8_fill);

    Path path_9 = Path();
    path_9.moveTo(size.width * 0.8554695, size.height * 0.9009761);
    path_9.cubicTo(
        size.width * 0.8597324,
        size.height * 0.9024821,
        size.width * 0.8634601,
        size.height * 0.9048845,
        size.width * 0.8664789,
        size.height * 0.9078884);
    path_9.cubicTo(
        size.width * 0.8689624,
        size.height * 0.9104462,
        size.width * 0.8709155,
        size.height * 0.9131474,
        size.width * 0.8723380,
        size.height * 0.9161554);
    path_9.cubicTo(
        size.width * 0.8737559,
        size.height * 0.9191594,
        size.width * 0.8744695,
        size.height * 0.9226175,
        size.width * 0.8744695,
        size.height * 0.9265219);
    path_9.cubicTo(
        size.width * 0.8744695,
        size.height * 0.9311793,
        size.width * 0.8730469,
        size.height * 0.9358406,
        size.width * 0.8702066,
        size.height * 0.9403466);
    path_9.cubicTo(
        size.width * 0.8673662,
        size.height * 0.9448566,
        size.width * 0.8627465,
        size.height * 0.9480120,
        size.width * 0.8563568,
        size.height * 0.9499641);
    path_9.cubicTo(
        size.width * 0.8616854,
        size.height * 0.9517649,
        size.width * 0.8655915,
        size.height * 0.9543227,
        size.width * 0.8677183,
        size.height * 0.9577769);
    path_9.cubicTo(
        size.width * 0.8700282,
        size.height * 0.9610837,
        size.width * 0.8710939,
        size.height * 0.9663426,
        size.width * 0.8710939,
        size.height * 0.9732550);
    path_9.lineTo(size.width * 0.8710939, size.height * 0.9798645);
    path_9.cubicTo(
        size.width * 0.8710939,
        size.height * 0.9843745,
        size.width * 0.8712723,
        size.height * 0.9873785,
        size.width * 0.8718028,
        size.height * 0.9890319);
    path_9.cubicTo(
        size.width * 0.8725164,
        size.height * 0.9915857,
        size.width * 0.8739343,
        size.height * 0.9933904,
        size.width * 0.8762441,
        size.height * 0.9945936);
    path_9.lineTo(size.width * 0.8762441, size.height * 0.9969960);
    path_9.lineTo(size.width * 0.8492535, size.height * 0.9969960);
    path_9.cubicTo(
        size.width * 0.8485446,
        size.height * 0.9947410,
        size.width * 0.8480094,
        size.height * 0.9930876,
        size.width * 0.8476573,
        size.height * 0.9917371);
    path_9.cubicTo(
        size.width * 0.8469484,
        size.height * 0.9890319,
        size.width * 0.8467700,
        size.height * 0.9861753,
        size.width * 0.8465915,
        size.height * 0.9831713);
    path_9.lineTo(size.width * 0.8464131, size.height * 0.9740040);
    path_9.cubicTo(
        size.width * 0.8462347,
        size.height * 0.9676932,
        size.width * 0.8449906,
        size.height * 0.9634861,
        size.width * 0.8425070,
        size.height * 0.9613825);
    path_9.cubicTo(
        size.width * 0.8400235,
        size.height * 0.9592789,
        size.width * 0.8354038,
        size.height * 0.9582271,
        size.width * 0.8286573,
        size.height * 0.9582271);
    path_9.lineTo(size.width * 0.8048638, size.height * 0.9582271);
    path_9.lineTo(size.width * 0.8048638, size.height * 0.9969960);
    path_9.lineTo(size.width * 0.7812488, size.height * 0.9969960);
    path_9.lineTo(size.width * 0.7812488, size.height * 0.8982749);
    path_9.lineTo(size.width * 0.8370047, size.height * 0.8982749);
    path_9.cubicTo(
        size.width * 0.8449906,
        size.height * 0.8985737,
        size.width * 0.8512066,
        size.height * 0.8994741,
        size.width * 0.8554695,
        size.height * 0.9009761);
    path_9.close();
    path_9.moveTo(size.width * 0.8050423, size.height * 0.9155538);
    path_9.lineTo(size.width * 0.8050423, size.height * 0.9421514);
    path_9.lineTo(size.width * 0.8313192, size.height * 0.9421514);
    path_9.cubicTo(
        size.width * 0.8364695,
        size.height * 0.9421514,
        size.width * 0.8403756,
        size.height * 0.9415498,
        size.width * 0.8430376,
        size.height * 0.9404980);
    path_9.cubicTo(
        size.width * 0.8476573,
        size.height * 0.9386932,
        size.width * 0.8499624,
        size.height * 0.9349363,
        size.width * 0.8499624,
        size.height * 0.9293785);
    path_9.cubicTo(
        size.width * 0.8499624,
        size.height * 0.9233665,
        size.width * 0.8476573,
        size.height * 0.9193108,
        size.width * 0.8432160,
        size.height * 0.9173546);
    path_9.cubicTo(
        size.width * 0.8407324,
        size.height * 0.9161554,
        size.width * 0.8370047,
        size.height * 0.9155538,
        size.width * 0.8318545,
        size.height * 0.9155538);
    path_9.lineTo(size.width * 0.8050423, size.height * 0.9155538);
    path_9.close();

    Paint paint_9_fill = Paint()..style = PaintingStyle.fill;
    paint_9_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_9, paint_9_fill);

    Path path_10 = Path();
    path_10.moveTo(size.width * 0.9311080, size.height * 0.8984223);
    path_10.lineTo(size.width * 0.9588075, size.height * 0.8984223);
    path_10.lineTo(size.width, size.height * 0.9971474);
    path_10.lineTo(size.width * 0.9735446, size.height * 0.9971474);
    path_10.lineTo(size.width * 0.9659108, size.height * 0.9768606);
    path_10.lineTo(size.width * 0.9229390, size.height * 0.9768606);
    path_10.lineTo(size.width * 0.9149484, size.height * 0.9971474);
    path_10.lineTo(size.width * 0.8895587, size.height * 0.9971474);
    path_10.lineTo(size.width * 0.9311080, size.height * 0.8984223);
    path_10.close();
    path_10.moveTo(size.width * 0.9295070, size.height * 0.9598805);
    path_10.lineTo(size.width * 0.9593380, size.height * 0.9598805);
    path_10.lineTo(size.width * 0.9446009, size.height * 0.9211116);
    path_10.lineTo(size.width * 0.9295070, size.height * 0.9598805);
    path_10.close();

    Paint paint_10_fill = Paint()..style = PaintingStyle.fill;
    paint_10_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_10, paint_10_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
