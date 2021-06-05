import 'package:flutter/material.dart';
import 'package:helpadora/src/screens/password_change_screen.dart';
import 'package:provider/provider.dart';

import '../../widgets/logout_button.dart';
import '../../widgets/profile_view.dart';
import '../../services/auth_services.dart';

class SettingsTab extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    final _deviceWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      children: [
        ProfileView(_auth.getCurrentUser().uid),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('Change Password'),
              onTap: () => Navigator.of(context).pushNamed(
                  ChangePasswordScreen.routeName,
                  arguments: {'_deviceWidth': _deviceWidth}),
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
        LogoutButton(_deviceWidth),
      ],
    );
  }
}
