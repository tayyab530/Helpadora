import 'package:flutter/material.dart';
import 'package:helpadora/src/models/theme_data.dart';
import 'package:provider/provider.dart';

class ThemeToggleTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeNotifier>(context, listen: false);
    bool isLight = _theme.isLight;

    return ListTile(
      leading: Icon(isLight ? Icons.nights_stay_outlined : Icons.nights_stay),
      title: Text(isLight ? 'Dark Mode' : 'Light Mode'),
      trailing: Switch(
        value: isLight ? false : true,
        onChanged: (value) {
          print(value);
          !value ? _theme.setLightMode() : _theme.setDarkMode();
        },
      ),
    );
  }
}
