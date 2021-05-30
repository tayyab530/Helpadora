import 'package:flutter/cupertino.dart';

class Message {
  final String receiverUid;
  final String senderUid;
  final String text;
  final DateTime dateTime;

  Message({
    @required this.receiverUid,
    @required this.senderUid,
    @required this.text,
    @required this.dateTime,
  });
}
