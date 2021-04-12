import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_services.dart';

class SettingsTab extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      children: [
        ElevatedButton(
          onPressed: () {
             _auth.signOut().then((value) => Navigator.of(context).pushReplacementNamed('/'));
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}