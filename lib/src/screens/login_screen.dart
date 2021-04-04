import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/main_screen.dart';
import 'package:helpadora/src/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(MainScreen.routeName),
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(RegistrationScreen.routeName),
              child: Text('or Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}
