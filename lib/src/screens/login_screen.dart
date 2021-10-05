import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'dart:ui' as ui;

import '../widgets/messages_popups.dart';
import '../blocs/login_bloc.dart';
import 'main_screen.dart';
import 'registration_screen.dart';
import '../services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  final _underLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final loginBloc = Provider.of<LoginBloc>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(
                        width,
                        (width * 0.7527777777777778)
                            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter(),
                  ),
                  Positioned(
                    right: 15.0,
                    top: 80.0,
                    child: Text(
                      'HELPADORA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: Column(
                  children: [
                    emailField(loginBloc),
                    passwordField(loginBloc),
                    SizedBox(
                      height: 20.0,
                    ),
                    loginButton(context, loginBloc, _auth),
                    _createUserButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createUserButton(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'or',
            textAlign: TextAlign.end,
            style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline1.color),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(RegistrationScreen.routeName),
            child: Text('Create an account'),
          ),
        ],
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              labelText: 'Email',
              errorStyle: TextStyle(color: Theme.of(context).disabledColor),
              errorText: snapshot.hasError ? snapshot.error : "",
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
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
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              labelText: 'Password',
              errorStyle: TextStyle(color: Theme.of(context).dividerColor),
              errorText: snapshot.hasError ? snapshot.error : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
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

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.09943985);
    path_0.lineTo(size.width, size.height * 0.09943985);
    path_0.cubicTo(size.width, size.height * 0.09943985, size.width,
        size.height * 0.5004096, size.width, size.height * 0.8821292);
    path_0.cubicTo(size.width, size.height * 1.263852, 0,
        size.height * 0.2726583, 0, size.height * 0.4747454);
    path_0.cubicTo(0, size.height * 0.6768339, 0, size.height * 0.09943985, 0,
        size.height * 0.09943985);
    path_0.close();

    // ignore: non_constant_identifier_names
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFFC107).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0, 0);
    path_1.lineTo(size.width, 0);
    path_1.cubicTo(size.width, 0, size.width, size.height * 0.4009668,
        size.width, size.height * 0.7826900);
    path_1.cubicTo(size.width, size.height * 1.164413, 0,
        size.height * 0.1732185, 0, size.height * 0.3753063);
    path_1.cubicTo(0, size.height * 0.5773948, 0, 0, 0, 0);
    path_1.close();

    // ignore: non_constant_identifier_names
    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, 0),
        Offset(size.width * 0.5000000, size.height * 0.8468450),
        [Color(0xff03A9F4).withOpacity(1), Color(0xff3EB1F1).withOpacity(0.3)],
        [0.114583, 1]);
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
