import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/list_of_queries.dart';

class SelfTab extends StatefulWidget {
  @override
  _SelfTabState createState() => _SelfTabState();
}

class _SelfTabState extends State<SelfTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListOfQueries(),
          height: 300.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Solved Queries'),
            IconButton(icon: Icon(Icons.expand_more), onPressed: () {}),
          ],
        ),
        Container(
          child: ListOfQueries(),
          height: 300.0,
        ),
      ],
    );
  }
}
