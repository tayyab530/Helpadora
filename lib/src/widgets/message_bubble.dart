import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

import 'package:helpadora/src/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final Message _message;
  final String _currentUid;

  MessageBubble(this._message, this._currentUid);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      padding: BubbleEdges.all(8.0),
      child: Text(
        _message.text,
        style: TextStyle(color: Colors.black),
      ),
      margin: BubbleEdges.all(10.0),
      color: _currentUid == _message.senderUid
          ? Color(0xFFFEE28E)
          : Theme.of(context).dividerColor,
      nip: _currentUid == _message.senderUid
          ? BubbleNip.rightBottom
          : BubbleNip.leftBottom,
      alignment: _currentUid == _message.senderUid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      elevation: 3,
    );
  }
}
