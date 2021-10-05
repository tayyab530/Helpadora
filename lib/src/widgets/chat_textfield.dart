import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/message_model.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ChatTextfield extends StatelessWidget {
  final _messageController = TextEditingController();
  final QueryModel _queryDetails;
  final List<dynamic> chatMembers;
  final Map<String, String> senderReceiver;

  ChatTextfield(this._queryDetails, this.chatMembers, this.senderReceiver);

  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final senderUid = senderReceiver['sender'];
    final receiverUid = senderReceiver['receiver'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      color: Theme.of(context).primaryColorLight,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  InputTextField(messageController: _messageController),
                  SendMessage(
                      messageController: _messageController,
                      dbFirestore: _dbFirestore,
                      uid: _uid,
                      receiverUid: receiverUid,
                      queryDetails: _queryDetails,
                      senderUid: senderUid),
                ],
              ),
            ),
          ),
          ThumbUp(
            dbFirestore: _dbFirestore,
            query: _queryDetails,
            senderUid: senderUid,
            receiverUid: receiverUid,
          ),
        ],
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key key,
    @required TextEditingController messageController,
  })  : _messageController = messageController,
        super(key: key);

  final TextEditingController _messageController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: TextField(
        controller: _messageController,
        maxLines: null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.black),
          hintText: 'type your message...',
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class SendMessage extends StatelessWidget {
  final TextEditingController _messageController;
  final DbFirestore _dbFirestore;
  final String _uid;
  final String receiverUid;
  final QueryModel _queryDetails;
  final String senderUid;

  const SendMessage({
    Key key,
    @required TextEditingController messageController,
    @required DbFirestore dbFirestore,
    @required String uid,
    @required this.receiverUid,
    @required QueryModel queryDetails,
    @required this.senderUid,
  })  : _messageController = messageController,
        _dbFirestore = dbFirestore,
        _uid = uid,
        _queryDetails = queryDetails,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TapDebouncer(
        onTap: () async {
          var text = _messageController.text;

          _messageController.clear();
          await _dbFirestore.sendChat(
              _toChat(_uid, text, receiverUid), _queryDetails, senderUid);
        },
        builder: (ctx, TapDebouncerFunc onTap) => IconButton(
          icon: Icon(
            Icons.send,
            color: Colors.black,
          ),
          onPressed: onTap,
        ),
      ),
    );
  }
}

class ThumbUp extends StatelessWidget {
  final DbFirestore dbFirestore;
  final QueryModel query;
  final String senderUid;
  final String receiverUid;

  const ThumbUp({
    Key key,
    this.dbFirestore,
    this.query,
    this.senderUid,
    this.receiverUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    return Expanded(
      flex: 1,
      child: IconButton(
        alignment: Alignment.centerRight,
        icon: Icon(Icons.thumb_up),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          dbFirestore.sendChat(
              _toChat(_uid, '👍', receiverUid),
              query,
              senderUid);
        },
      ),
    );
  }
}

_toChat(String senderUid, String text, String rUid) {
  return Message(
      text: text,
      senderUid: senderUid,
      receiverUid: rUid,
      time: Timestamp.now());
}
