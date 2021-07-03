import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chat {
  final String toUid;
  final String fromUid;
  final String lastmessage;
  final Timestamp time;
  final String qid;
  final String qTitle;

  Chat({
    @required this.toUid,
    @required this.fromUid,
    @required this.lastmessage,
    @required this.time,
    @required this.qid,
    @required this.qTitle,
  });
}
