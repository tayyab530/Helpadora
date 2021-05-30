import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/message_Popup.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../blocs/login_bloc.dart';
import 'main_screen.dart';
import 'registration_screen.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                emailField(loginBloc),
                passwordField(loginBloc),
                SizedBox(
                  height: 20.0,
                ),
                loginButton(context, loginBloc, _auth),
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RegistrationScreen.routeName),
                  child: Text('or Create an account'),
                ),
              ],
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
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
          );
        });
  }

  Widget passwordField(LoginBloc bloc) {
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

  Widget loginButton(
      BuildContext context, LoginBloc loginBloc, AuthService authServices) {
    return StreamBuilder(
        stream: loginBloc.submit,
        // initialData: null,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return TapDebouncer(
            onTap: !snapshot.hasData
                ? null
                : () async {
                    var user = await authServices.loginWithEandP(
                      loginBloc.getEmail(),
                      loginBloc.getPassword(),
                    );
                    if (user == null) {
                      Dialogs.showErrorDialog(context, authServices.getError());
                    } else
                      Navigator.of(context)
                          .pushReplacementNamed(MainScreen.routeName);
                  },
            builder: (ctx, TapDebouncerFunc onTap) => Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onTap,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
              ),
            ),
          );
        });
  }
}
