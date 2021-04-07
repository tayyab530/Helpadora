import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/registration_bloc.dart';
import 'package:helpadora/src/screens/main_screen.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var currentDate = DateTime(1997);
  var regisBloc;
  String gender = '', program = '', date = '';

  @override
  Widget build(BuildContext context) {
    regisBloc = Provider.of<RegistrationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            userNameField(regisBloc),
            emailField(regisBloc),
            createPasswordField(regisBloc),
            confirmPasswordField(regisBloc),
            buildGenderDropDown(),
            buildDatePicker(),
            buildProgramDropDown(),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(MainScreen.routeName),
              child: Text('Register'),
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
              errorText: !snapshot.data ? 'Password does not match!' : '',
            ),
            onChanged: bloc.changeConfirmPassword,
          );
        });
  }

  Widget buildGenderDropDown() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: DropdownButton(
        hint: Text('Gender'),
        icon: Row(
          children: [
            gender == ''
                ? Container(
                    width: 75.0,
                  )
                : Container(
                    padding: EdgeInsets.all(4.0),
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Container(
                      child: Text(gender),
                    ),
                  ),
            Icon(Icons.expand_more),
          ],
        ),
        items: [
          DropdownMenuItem(
            value: 'Male',
            child: Text('Male'),
          ),
          DropdownMenuItem(
            value: 'Female',
            child: Text('Female'),
          ),
          DropdownMenuItem(
            value: 'Other',
            child: Text('Other'),
          ),
        ],
        onChanged: (gender) {
          setState(() {
            this.gender = gender;
          });
        },
      ),
    );
  }

  Widget buildDatePicker() {
    return Row(
      children: [
        Text('Date of Birth'),
        date == ''
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
                  child: Text(date),
                ),
              ),
        IconButton(
          icon: Icon(Icons.calendar_today_rounded),
          onPressed: () {
            _datePicker(context);
          },
        )
      ],
    );
  }

  Widget buildProgramDropDown() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: DropdownButton(
        hint: Text('Program'),
        icon: Row(
          children: [
            program == ''
                ? Container(
                    width: 75.0,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Container(
                      child: Text(program),
                    ),
                  ),
            Icon(Icons.expand_more),
          ],
        ),
        items: [
          DropdownMenuItem(
            value: 'CS',
            child: Text('CS'),
          ),
          DropdownMenuItem(
            value: 'Pharm.D',
            child: Text('Pharm.D'),
          ),
          DropdownMenuItem(
            value: 'BBA',
            child: Text('BBA'),
          ),
          DropdownMenuItem(
            value: 'ACF',
            child: Text('ACF'),
          ),
          DropdownMenuItem(
            value: 'BME',
            child: Text('BME'),
          ),
          DropdownMenuItem(
            value: 'BS',
            child: Text('BS'),
          ),
        ],
        onChanged: (program) {
          setState(() {
            this.program = program;
          });
        },
      ),
    );
  }

  Future<void> _datePicker(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1995),
      lastDate: DateTime(2015),
      currentDate: currentDate,
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(
        () {
          currentDate = pickedDate;
          date = "${pickedDate.day}/${pickedDate.month}";
        },
      );
  }
}
