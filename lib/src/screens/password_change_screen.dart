import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/registration_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const routeName = '/password';

  @override
  Widget build(BuildContext context) {
    final Map<String, double> _deviceWidth =
        ModalRoute.of(context).settings.arguments;
    final _registerBloc = Provider.of<RegistrationBloc>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        child: Column(
          children: [
            currentPasswordField(),
            newPasswordField(),
            retypePasswordField(),
            resetButton(context, _deviceWidth['_deviceWidth']),
          ],
        ),
      ),
    );
  }

  Widget currentPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Old Password',
        errorText: '',
      ),
      onChanged: (value) {},
    );
  }

  Widget newPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'New Password',
        errorText: '',
      ),
    );
  }

  Widget retypePasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Retype Password',
        errorText: '',
      ),
    );
  }

  Widget resetButton(BuildContext context, double _deviceWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.2),
      child: TapDebouncer(
        onTap: () async {},
        builder: (ctx, TapDebouncerFunc onTap) => Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            child: Text('Reset'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
