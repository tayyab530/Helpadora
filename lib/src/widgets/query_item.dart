import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'message_Popup.dart';

class QueryItem extends StatelessWidget {
  final QueryDocumentSnapshot queryDetails;

  QueryItem(this.queryDetails);

  @override
  Widget build(BuildContext context) {
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).primaryColorLight,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  queryDetails['title'],
                  style: TextStyle(
                    fontWeight:
                        Theme.of(context).primaryTextTheme.headline1.fontWeight,
                    fontSize: 19.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            trailing: Text(queryDetails['due_date']),
            subtitle: Row(
              children: [
                Icon(Icons.location_on),
                Text(queryDetails['location']),
              ],
            ),
            onTap: () {
              Dialogs.queryDetailsDialog(
                context,
                queryDetails,
                isMe(_uid, queryDetails.data()['poster_uid']),
                [_uid, queryDetails.data()['poster_uid']],
              );
            },
          ),
        ),
        Divider(),
      ],
    );
  }

  bool isMe(String currentUser, String posterUid) =>
      currentUser != posterUid ? true : false;
}
