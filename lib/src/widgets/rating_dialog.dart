import 'package:flutter/material.dart';
import 'package:helpadora/src/constants/device_dimensions_info.dart';
import 'package:helpadora/src/screens/main_screen.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

class RatingDialog extends StatefulWidget {
  final String solverUid;
  final String queryId;

  RatingDialog(
    this.solverUid,
    this.queryId,
  );
  @override
  _RatingDialogBoxState createState() => _RatingDialogBoxState();
}

class _RatingDialogBoxState extends State<RatingDialog> {
  double _value = 1.0;

  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _deviceWidth = MediaQuery.of(context).size.width;

    return SimpleDialog(
      title: Text(
        'Please give points to your solver',
        style: TextStyle(
            fontWeight: Theme.of(context).accentTextTheme.headline2.fontWeight),
      ),
      children: [
        Slider(
          min: 1,
          max: 10,
          value: _value,
          onChanged: (value) {
            _value = value;
            setState(() {});
          },
          divisions: 18,
          label: _value.toString(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.2),
          child: TextButton(
            child: Text('Submit'),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).accentColor,
              primary: Theme.of(context).primaryTextTheme.headline1.color,
            ),
            onPressed: () {
              _dbFirestore.solveQuery(widget.queryId, widget.solverUid, _value);
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            },
          ),
        ),
      ],
    );
  }
}
