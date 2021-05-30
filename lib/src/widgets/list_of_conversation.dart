import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../services/auth_services.dart';
import '../services/db_firestore.dart';
import '../widgets/conversation_item.dart';

class ListOfConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder(
        stream: null,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          var messages = snapshot.data.docs;
          return ListView.builder(
            padding: EdgeInsets.only(top: 5.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var message = messages[index];

              return ConversationItem(Message(
                  receiverUid: message['receiver_uid'],
                  senderUid: message['sender_uid'],
                  text: message['text'],
                  dateTime: formatTimestamp(message['time'])));
            },
          );
        });
  }

  DateTime formatTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}
