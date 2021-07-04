import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  final String lastMessage;
  final Timestamp time;
  final List<dynamic> chatMembers;
  final QueryModel queryDetails;
  final String chatId;

  ConversationItem(this.queryDetails, this.lastMessage, this.time,
      this.chatMembers, this.chatId);

  @override
  Widget build(BuildContext context) {
    var _time = DateFormat('hh:mm a').format(time.toDate());
    return ListTile(
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
        Navigator.of(context).pushNamed('/chat/$chatId', arguments: {
          'queryDetails': queryDetails,
          'chatMembers': chatMembers
        });
      },
    );
  }
}
