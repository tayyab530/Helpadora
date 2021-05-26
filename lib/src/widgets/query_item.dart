import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_Popup.dart';

class QueryItem extends StatelessWidget {
  final QueryDocumentSnapshot queryDetails;

  QueryItem(this.queryDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(queryDetails['title']),
          trailing: Text(queryDetails['due_date']),
          subtitle: Row(
            children: [
              Icon(Icons.location_on),
              Text(queryDetails['location']),
            ],
          ),
          onTap: () {
            Dialogs.queryDetailsDialog(context, queryDetails);
          },
        ),
        Divider(),
      ],
    );
  }
}
