import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../blocs/registration_bloc.dart';
import '../models/date_model.dart';
import '../services/auth_services.dart';
import '../widgets/message_Popup.dart';
import '../models/dialog_messages.dart';
import '../screens/login_screen.dart';
import '../services/db_firestore.dart';
import '../models/user_model.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = '/registration';

  @override
  Widget build(BuildContext context) {
    final _regisBloc = Provider.of<RegistrationBloc>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
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
              labelText: 'UserName',
              errorText: snapshot.hasError ? snapshot.error : '',
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
            decoration: InputDecoration(
              labelText: 'Email Address',
              errorText: snapshot.hasError ? snapshot.error : '',
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
              labelText: 'Create Password',
              errorText: snapshot.hasError ? snapshot.error : '',
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
              labelText: 'Confirm Password',
              errorText: !snapshot.hasData ? 'Password does not match!' : '',
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
              hint: Text('Gender'),
              icon: Row(
                children: [
                  snapshot.data == null
                      ? Container(
                          width: 75.0,
                        )
                      : Container(
                          padding: EdgeInsets.all(4.0),
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Container(
                            child: Text(snapshot.data),
                          ),
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
              onChanged: (Gender gender) {
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
          return Row(
            children: [
              Text('Date of Birth'),
              snapshot.data == null
                  ? Container()
                  : Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        child: Text(
                            "${snapshot.data.pickedDate.day}/${snapshot.data.pickedDate.month}"),
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
              hint: Text('Program'),
              icon: Row(
                children: [
                  snapshot.data == null
                      ? Container(
                          width: 75.0,
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Container(
                            child: Text(snapshot.data),
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
              onChanged: (Program program) {
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
                      ));
                    } else
                      Dialogs.showErrorDialog(context, _authService.getError());
                    print(_authService.getError());
                  });
                }
              : null,
          builder: (ctx, TapDebouncerFunc onTap) => Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _datePicker(BuildContext context, RegistrationBloc _regisBloc,
      AsyncSnapshot<Date> snapshot) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: snapshot.data.currentDate,
      firstDate: DateTime(1995),
      lastDate: DateTime(2015),
      currentDate: snapshot.data.currentDate,
    );
    if (pickedDate != null && pickedDate != snapshot.data.currentDate) {
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
