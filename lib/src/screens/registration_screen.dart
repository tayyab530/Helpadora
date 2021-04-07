import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/registration_bloc.dart';
import 'package:helpadora/src/screens/main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var currentDate = DateTime(1997);

  @override
  Widget build(BuildContext context) {
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
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Create Password',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            buildGenderDropDown(),
            Row(
              children: [
                Text('Date of Birth'),
                IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () {
                    _datePicker(context);
                  },
                )
              ],
            ),
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
      builder: (context,AsyncSnapshot<String> snapshot) {
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
      builder: (context,AsyncSnapshot<String> snapshot) {
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
      builder: (context,AsyncSnapshot<String> snapshot) {
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
      builder: (context,AsyncSnapshot<bool> snapshot) {
      return TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          errorText: !snapshot.data ? 'Password does not match!': '' ,
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
        icon: Icon(Icons.expand_more),
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
        onChanged: (value) {},
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
        },
      );
  }

  Widget buildProgramDropDown() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: DropdownButton(
        hint: Text('Program'),
        icon: Icon(Icons.cast_for_education_rounded),
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
        onChanged: (value) {},
      ),
    );
  }
}
