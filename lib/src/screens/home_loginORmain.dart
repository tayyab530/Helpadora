import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';
import 'main_screen.dart';
import '../services/auth_services.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _isLoggedIn =
        Provider.of<AuthService>(context, listen: false).isLogedIn();

    return _isLoggedIn ? MainScreen() : LoginScreen();
  }
}
