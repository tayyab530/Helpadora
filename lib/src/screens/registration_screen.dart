import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import 'dart:ui' as ui;

import '../blocs/registration_bloc.dart';
import '../models/date_model.dart';
import '../services/auth_services.dart';
import '../widgets/messages_popups.dart';
import '../models/dialog_messages.dart';
import '../screens/login_screen.dart';
import '../services/db_firestore.dart';
import '../models/user_model.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/registration';
  final _underLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final _regisBloc = Provider.of<RegistrationBloc>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(
                      _width,
                      (_width * 0.4666666666666667)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPSCustomPainter(),
                ),
                Positioned(
                  top: 50.0,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 35.0,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                children: [
                  userNameField(_regisBloc),
                  emailField(_regisBloc),
                  createPasswordField(_regisBloc),
                  confirmPasswordField(_regisBloc),
                  genderDropDown(_regisBloc),
                  datePicker(_regisBloc),
                  programDropDown(_regisBloc),
                  SizedBox(
                    height: 20.0,
                  ),
                  registerButton(_regisBloc, _auth, _dbFirestore),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userNameField(RegistrationBloc bloc) {
    return StreamBuilder(
        stream: bloc.userName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Theme.of(context).dividerColor),
              labelText: 'UserName',
              errorText: snapshot.hasError ? snapshot.error.toString() : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: bloc.changeUserName,
          );
        });
  }

  Widget emailField(RegistrationBloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Theme.of(context).dividerColor),
              labelText: 'Email Address',
              errorText: snapshot.hasError ? snapshot.error.toString() : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: bloc.changeEmail,
          );
        });
  }

  Widget createPasswordField(RegistrationBloc bloc) {
    return StreamBuilder(
        stream: bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Theme.of(context).dividerColor),
              labelText: 'Create Password',
              errorText: snapshot.hasError ? snapshot.error.toString() : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: bloc.changePassword,
          );
        });
  }

  Widget confirmPasswordField(RegistrationBloc bloc) {
    return StreamBuilder(
        stream: bloc.confirmPassword,
        initialData: true,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return TextField(
            obscureText: true,
            decoration: InputDecoration(
              errorStyle: TextStyle(color: Theme.of(context).dividerColor),
              labelText: 'Confirm Password',
              errorText: !snapshot.hasData ? 'Password does not match!' : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: bloc.changeConfirmPassword,
          );
        });
  }

  Widget genderDropDown(RegistrationBloc _regisBloc) {
    return StreamBuilder(
        stream: _regisBloc.gender,
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.bottomLeft,
            child: DropdownButton(
              hint: Text('Gender '),
              icon: Row(
                children: [
                  if (snapshot.data != null)
                    Chip(
                      label: Text(snapshot.data!),
                    ),
                  Icon(Icons.expand_more),
                ],
              ),
              items: [
                DropdownMenuItem(
                  value: Gender.Male,
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: Gender.Female,
                  child: Text('Female'),
                ),
                DropdownMenuItem(
                  value: Gender.Other,
                  child: Text('Other'),
                ),
              ],
              onChanged: (Gender? gender) {
                _regisBloc.changeGender(gender
                    .toString()
                    .replaceAllMapped('Gender.', (match) => ''));
              },
            ),
          );
        });
  }

  Widget datePicker(RegistrationBloc _regisBloc) {
    return StreamBuilder(
        stream: _regisBloc.date,
        initialData: Date(DateTime(1997), DateTime(1997)),
        builder: (context, AsyncSnapshot<Date> snapshot) {
          final _pickedDate = snapshot.data!.pickedDate;
          return Row(
            children: [
              Text('Date of Birth '),
              if (snapshot.data != null)
                Chip(
                  label: Container(
                    child: Text(
                        "${_pickedDate.day}/${_pickedDate.month}/${_pickedDate.year}"),
                  ),
                ),
              IconButton(
                icon: Icon(Icons.calendar_today_rounded),
                onPressed: () {
                  _datePicker(context, _regisBloc, snapshot);
                },
              )
            ],
          );
        });
  }

  Widget programDropDown(RegistrationBloc _regisBloc) {
    return StreamBuilder(
        stream: _regisBloc.program,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Container(
            alignment: Alignment.bottomLeft,
            child: DropdownButton(
              hint: Text('Program '),
              icon: Row(
                children: [
                  if (snapshot.data != null)
                    Chip(
                      label: Container(
                        child: Text(snapshot.data!),
                      ),
                    ),
                  Icon(Icons.expand_more),
                ],
              ),
              items: [
                DropdownMenuItem(
                  value: Program.CS,
                  child: Text('CS'),
                ),
                DropdownMenuItem(
                  value: Program.PharmD,
                  child: Text('Pharm.D'),
                ),
                DropdownMenuItem(
                  value: Program.BBA,
                  child: Text('BBA'),
                ),
                DropdownMenuItem(
                  value: Program.ACF,
                  child: Text('ACF'),
                ),
                DropdownMenuItem(
                  value: Program.BME,
                  child: Text('BME'),
                ),
                DropdownMenuItem(
                  value: Program.BS,
                  child: Text('BS'),
                ),
              ],
              onChanged: (Program? program) {
                _regisBloc.changeProgram(program
                    .toString()
                    .replaceAllMapped('Program.', (match) => ''));
              },
            ),
          );
        });
  }

  Widget registerButton(RegistrationBloc _regisBloc, AuthService _authService,
      DbFirestore _dbFirestore) {
    return StreamBuilder(
      stream: _regisBloc.submitForReg,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TapDebouncer(
          onTap: snapshot.hasData
              ? () async {
                  await _authService
                      .registerWithEandP(
                          _regisBloc.getEmail(), _regisBloc.getPassword())
                      .then((user) {
                    if (user != null) {
                      Dialogs.showConfirmationDialog(
                          context,
                          DialogMessages.registrationConfirm,
                          LoginScreen.routeName);
                      _regisBloc.dispose();
                      _dbFirestore.registerUserData(UserModel(
                        uid: _authService.getCurrentUser().uid,
                        userName: _regisBloc.getUserName(),
                        dob: _regisBloc.getDob(),
                        gender: _regisBloc.getGender(),
                        program: _regisBloc.getProgram(),
                        emailAddress: user.email,
                      ));
                    } else
                      Dialogs.showErrorDialog(context, _authService.getError());
                  });
                }
              : null,
          builder: (ctx, TapDebouncerFunc? onTap) => Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _datePicker(BuildContext context, RegistrationBloc _regisBloc,
      AsyncSnapshot<Date> snapshot) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: snapshot.data!.currentDate,
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year - 10),
      currentDate: snapshot.data!.currentDate,
    );
    if (pickedDate != null && pickedDate != snapshot.data!.currentDate) {
      _regisBloc.changeDate(Date(pickedDate, pickedDate));
    }
  }
}

enum Gender {
  Male,
  Female,
  Other,
}

enum Program {
  CS,
  BBA,
  PharmD,
  BS,
  BME,
  ACF,
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.1011905);
    path_0.lineTo(0, size.height * 0.1011905);
    path_0.cubicTo(0, size.height * 0.1011905, 0, size.height * 0.4930220, 0,
        size.height * 0.8660476);
    path_0.cubicTo(0, size.height * 1.239071, size.width,
        size.height * 0.2704619, size.width, size.height * 0.4679446);
    path_0.cubicTo(size.width, size.height * 0.6654286, size.width,
        size.height * 0.1011905, size.width, size.height * 0.1011905);
    path_0.close();

    Paint paint0fill = Paint()..style = PaintingStyle.fill;
    paint0fill.color = Color(0xffFFC107).withOpacity(1.0);
    canvas.drawPath(path_0, paint0fill);

    Path path_1 = Path();
    path_1.moveTo(size.width, 0);
    path_1.lineTo(0, 0);
    path_1.cubicTo(
        0, 0, 0, size.height * 0.3918315, 0, size.height * 0.7648571);
    path_1.cubicTo(0, size.height * 1.137881, size.width,
        size.height * 0.1692714, size.width, size.height * 0.3667542);
    path_1.cubicTo(
        size.width, size.height * 0.5642369, size.width, 0, size.width, 0);
    path_1.close();

    Paint paint1fill = Paint()..style = PaintingStyle.fill;
    paint1fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5000000, 0),
        Offset(size.width * 0.5000000, size.height * 0.8275476),
        [Color(0xff03A9F4).withOpacity(1), Color(0xff3EB1F1).withOpacity(0.3)],
        [0.114583, 1]);
    canvas.drawPath(path_1, paint1fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
