import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/query_model.dart';

class ConversationItemModel {
  final String chatID;
  final QueryModel query;
  final String lastMessage;
  final Timestamp sentTime;
  final Map<String, String> chatMembers;

  ConversationItemModel({
    @required this.chatID,
    @required this.query,
    @required this.lastMessage,
    @required this.sentTime,
    @required this.chatMembers,
  });

  ConversationItemModel.fromFirestore(
      QueryDocumentSnapshot _chatFromFirestore, QueryModel _query)
      : this.chatID = _chatFromFirestore.id,
        this.query = _query,
        this.lastMessage = _chatFromFirestore.data()['last_message'],
        this.sentTime = _chatFromFirestore.data()['time'],
        this.chatMembers = {
          'sender_uid': _chatFromFirestore.data()['sender_uid'],
          'receiver_uid': _chatFromFirestore.data()['receiver_uid']
        };
}
