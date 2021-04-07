import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/login_bloc.dart';
import 'package:helpadora/src/screens/main_screen.dart';
import 'package:helpadora/src/screens/registration_screen.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailField(loginBloc),
            password(loginBloc),
            SizedBox(
              height: 20.0,
            ),
            buildLoginButton(context),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RegistrationScreen.routeName),
              child: Text('or Create an account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: snapshot.hasError ? snapshot.error : "",
            ),
            onChanged: bloc.changeEmail,
          );
        });
  }

  Widget password(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: snapshot.hasError ? snapshot.error : '',
            ),
            onChanged: bloc.changePassword,
          );
        });
  }

  Widget buildLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed(MainScreen.routeName),
      child: Text('Login'),
    );
  }
}
