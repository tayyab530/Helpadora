import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/message_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

import 'message_bubble.dart';

class MessagesList extends StatelessWidget {
  final QueryDocumentSnapshot queryDetails;
  final senderUid;

  MessagesList(this.queryDetails, this.senderUid);
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _currentUid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;

    return StreamBuilder(
        stream: _dbFirestore.meChatStream(queryDetails, senderUid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            reverse: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return MessageBubble(
                  toMessage(snapshot.data.docs[index]), _currentUid);
            },
          );
        });
  }

  Message toMessage(QueryDocumentSnapshot message) {
    return Message(
        receiverUid: message['receiver_uid'],
        senderUid: message['sender_uid'],
        text: message['text'],
        dateTime: message['time'].toDate());
  }
}
