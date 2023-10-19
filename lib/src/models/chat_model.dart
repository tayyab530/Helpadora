import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/query_model.dart';

class Chat {
  final String toUid;
  final String fromUid;
  final String lastmessage;
  final Timestamp time;
  final String qid;
  final String qTitle;

  Chat({
    required this.toUid,
    required this.fromUid,
    required this.lastmessage,
    required this.time,
    required this.qid,
    required this.qTitle,
  });

  Chat.fromFirestore(DocumentSnapshot _chat, QueryModel query)
      : this.toUid = (_chat.data()! as Map<String,dynamic>)['receiver_uid'],
        this.fromUid = (_chat.data()! as Map<String,dynamic>)['sender_uid'],
        this.lastmessage = (_chat.data()! as Map<String,dynamic>)['last_message'],
        this.time = (_chat.data()! as Map<String,dynamic>)['time'],
        this.qid = (_chat.data()! as Map<String,dynamic>)['qid'],
        this.qTitle = query.title;
}
