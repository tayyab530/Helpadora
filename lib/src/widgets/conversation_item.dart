import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  final String lastMessage;
  final Timestamp time;
  final Map<String, String> chatMembers;
  final QueryModel queryDetails;

  ConversationItem(
      this.queryDetails, this.lastMessage, this.time, this.chatMembers);

  @override
  Widget build(BuildContext context) {
    var _time = DateFormat('hh:mm a').format(time.toDate());
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
            backgroundColor: Theme.of(context).dividerColor,
          ),
          title: Text(
            lastMessage,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(' $_time'),
          onTap: () {
            Navigator.of(context).pushNamed('/chat', arguments: {
              'queryDetails': queryDetails,
              'chatMembers': chatMembers
            });
          },
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
