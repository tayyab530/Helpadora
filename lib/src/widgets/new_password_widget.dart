import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/main_screen.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/widgets/messages_popups.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../blocs/change_password_bloc.dart';

class NewPassWord extends StatelessWidget {
  final double _deviceWidth;

  NewPassWord(this._deviceWidth);
  @override
  Widget build(BuildContext context) {
    final _changePasswordBloc =
        Provider.of<ChangePasswordBloc>(context, listen: false);
    final _user =
        Provider.of<AuthService>(context, listen: false).getCurrentUser();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Column(
        children: [
          newPasswordField(_changePasswordBloc),
          retypePasswordField(_changePasswordBloc),
          resetButton(context, _deviceWidth, _changePasswordBloc, _user),
        ],
      ),
    );
  }

  Widget newPasswordField(ChangePasswordBloc changePasswordBloc) {
    return StreamBuilder(
      stream: changePasswordBloc.newPassword,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Enter new password',
            labelText: 'New Password',
            errorText: snapshot.hasData ? '' : snapshot.error.toString(),
          ),
          onChanged: changePasswordBloc.changeNewPassword,
        );
      },
    );
  }

  Widget retypePasswordField(ChangePasswordBloc changePasswordBloc) {
    return StreamBuilder(
      stream: changePasswordBloc.retypePassword,
      initialData: true,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Retype Password',
            errorText: (!snapshot.hasData) ? 'Password does not match' : '',
          ),
          onChanged: changePasswordBloc.changeRetypePassword,
        );
      },
    );
  }

  Widget resetButton(BuildContext context, double _deviceWidth,
      ChangePasswordBloc changePasswordBloc, User _user) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.2),
      child: TapDebouncer(
        onTap: () async {
          await _user.updatePassword(changePasswordBloc.getNewPassword());
          Dialogs.showConfirmationDialog(
              context, 'Password is reset', MainScreen.routeName);
        },
        builder: (ctx, TapDebouncerFunc? onTap) => StreamBuilder(
            stream: changePasswordBloc.resetPassword,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return ElevatedButton(
                onPressed: snapshot.hasData ? onTap : null,
                child: Text('Reset'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).errorColor,
                ),
              );
            }),
      ),
    );
  }
}
