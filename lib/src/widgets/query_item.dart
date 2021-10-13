import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'messages_popups.dart';

class QueryItem extends StatelessWidget {
  final QueryModel queryDetails;

  QueryItem(this.queryDetails);

  @override
  Widget build(BuildContext context) {
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final String _dueDate = queryDetails.dueDate;
    final theme = Theme.of(context);
    final primaryTextTheme = theme.primaryTextTheme;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).primaryColorLight,
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                color: theme.shadowColor,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  queryDetails.title,
                  style: TextStyle(
                      fontWeight: primaryTextTheme.headline1.fontWeight,
                      fontSize: primaryTextTheme.headline1.fontSize,
                      color: primaryTextTheme.headline1.color),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: theme.primaryColorDark.withOpacity(0.8),
                ),
                Text(
                  queryDetails.location,
                  style: TextStyle(color: primaryTextTheme.headline1.color),
                ),
              ],
            ),
            trailing: Text(
              _dueDate,
              style: TextStyle(color: primaryTextTheme.headline2.color),
            ),
            onTap: () {
              Dialogs.queryDetailsDialog(
                context,
                queryDetails,
                isMe(_uid, queryDetails.posterUid),
                {"sender_uid": _uid, 'receiver_uid': queryDetails.posterUid},
              );
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  bool isMe(String currentUser, String posterUid) =>
      currentUser != posterUid ? true : false;
}
