import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/widgets/messages_popups.dart';
import 'package:provider/provider.dart';

class LoginForChangePassword extends StatelessWidget {
  final _passwordController = TextEditingController();
  final Function showPassowordChange;

  LoginForChangePassword(this.showPassowordChange);

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _auth.getCurrentUser().email,
            style: TextStyle(
              fontSize: Theme.of(context).primaryTextTheme.headline1.fontSize,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          passwordField(),
          submitButton(context, _auth),
        ],
      ),
    );
  }

  Widget passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Enter password',
        labelText: 'Password',
        errorText: !passwordValidation() ? '' : 'Please enter valid password',
      ),
    );
  }

  Widget submitButton(BuildContext context, AuthService _auth) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () async {
          var user = await _auth.loginWithEandP(
              _auth.getCurrentUser().email, _passwordController.text);
          if (user == null)
            Dialogs.showErrorDialog(context, _auth.getError());
          else
            showPassowordChange();
        },
        child: Text('Next'),
      ),
    );
  }

  bool passwordValidation() =>
      _passwordController.text.length < 6 ? false : true;
}
