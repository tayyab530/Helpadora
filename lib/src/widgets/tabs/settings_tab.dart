import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/screens/password_change_screen.dart';
import 'package:helpadora/src/widgets/theme_toggle_tile.dart';
import 'package:provider/provider.dart';

import '../../widgets/logout_button.dart';
import '../../widgets/profile_view.dart';
import '../../services/auth_services.dart';

class SettingsTab extends StatelessWidget {
  static const routeName = '/settings';
  static const icon = HelpadoraIcons.hamburger;
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);
    final _deviceWidth = MediaQuery.of(context).size.width;

    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 30.0),
          child: ProfileView(_auth.getCurrentUser().uid),
        ),
        passwordTile(
          context,
          Icons.vpn_key,
          'Change Password',
          () => Navigator.of(context).pushNamed(
            ChangePasswordScreen.routeName,
            arguments: {'_deviceWidth': _deviceWidth},
          ),
        ),
        darkThemeTile(
          context,
          'Dark Theme',
        ),
        LogoutButton(_deviceWidth),
      ],
    );
  }

  Widget passwordTile(
      BuildContext context, IconData icon, String title, Function function) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: function,
        ),
        divider
      ],
    );
  }

  Widget darkThemeTile(BuildContext context, String title) {
    return Column(
      children: [ThemeToggleTile(), divider],
    );
  }

  Widget get divider => Divider(
        color: Colors.black,
        indent: 10.0,
        endIndent: 10.0,
      );
}
