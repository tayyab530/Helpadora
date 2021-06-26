import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/notifiers/theme_data.dart';
import 'package:provider/provider.dart';

class ThemeToggleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeNotifier>(context, listen: false);
    bool isLight = _theme.isLight;

    return ListTile(
      leading: Icon(
          isLight ? HelpadoraIcons.theme_light : HelpadoraIcons.theme_dark),
      title: Text('Dark Mode'),
      trailing: Switch(
        value: isLight ? false : true,
        onChanged: (_isLight) {
          print(_isLight);
          !_isLight ? _theme.setLightMode() : _theme.setDarkMode();
        },
      ),
    );
  }
}
