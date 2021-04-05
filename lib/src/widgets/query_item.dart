import 'package:flutter/material.dart';

class QueryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Query Title'),
      trailing: Text("${DateTime.now().toString()}"),
      subtitle: Row(
        children: [
          Icon(Icons.location_on),
          Text('Library'),
        ],
      ),
    );
  }
}
