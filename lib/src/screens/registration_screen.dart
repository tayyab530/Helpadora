import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            TextField(
              decoration: InputDecoration(
                labelText: 'UserName',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
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
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderDropDown() {
    return Container(
      alignment: Alignment.bottomLeft,
      child: DropdownButton(
        hint: Text('Gender'),
        icon: Icon(Icons.arrow_downward_rounded),
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
}
