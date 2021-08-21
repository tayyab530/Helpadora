import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/login_bloc.dart';
import 'package:helpadora/src/notifiers/theme_data.dart';
import 'package:helpadora/src/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'main_screen.dart';
import '../services/auth_services.dart';

class Home extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    final showOnboarding =
        Provider.of<ThemeNotifier>(context, listen: false).showOnboarding;
    print('showOnboarding ' + showOnboarding.toString());
    if (showOnboarding) {
      print('showOnboarding ' + showOnboarding.toString());
      return OnboardingScreen();
    } else {
      print('home widget');
      final _isLoggedIn =
          Provider.of<AuthService>(context, listen: false).isLogedIn();
      return _isLoggedIn
          ? MainScreen()
          : ChangeNotifierProvider(
              create: (context) => LoginBloc(),
              child: LoginScreen(),
            );
    }
  }
}
