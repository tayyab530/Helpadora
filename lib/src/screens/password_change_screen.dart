import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/login_for_change_password_widget.dart';
import 'package:provider/provider.dart';
import '../services/auth_services.dart';

import '../widgets/new_password_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var isLogedin = false;
  @override
  Widget build(BuildContext context) {
    final Map<String, double> _deviceWidth =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: !isLogedin
          ? LoginForChangePassword(showPasswordChange)
          : NewPassWord(_deviceWidth['_deviceWidth']),
    );
  }

  showPasswordChange() {
    setState(() {
      isLogedin = true;
    });
  }
}
