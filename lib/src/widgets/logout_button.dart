import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatelessWidget {
  final double _deviceWidth;

  LogoutButton(this._deviceWidth);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.3),
      child: ElevatedButton(
        onPressed: () {
          _auth.signOut().then(
            (value) {
              Navigator.of(context).pushReplacementNamed('/');
            },
          );
        },
        child: Text('Logout',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
