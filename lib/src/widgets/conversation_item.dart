import 'package:flutter/material.dart';
import 'package:helpadora/src/models/message_model.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  final Message message;

  ConversationItem(this.message);
  @override
  Widget build(BuildContext context) {
    var _time = DateFormat('hh:mm a').format(message.dateTime);
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
            message.text,
            softWrap: true,
          ),
          trailing: Text(' $_time'),
        ),
        Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
