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
      child: Text(_message.text),
      margin: BubbleEdges.all(10.0),
      color: Theme.of(context).primaryColorLight,
      nip: BubbleNip.rightBottom,
      alignment: _currentUid == _message.senderUid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      elevation: 5,
    );
  }
}
