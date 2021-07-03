import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final String senderUid;
  final String receiverUid;
  final Timestamp time;

  Message({
    @required this.text,
    @required this.senderUid,
    @required this.receiverUid,
    @required this.time,
  });
}
