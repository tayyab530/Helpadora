import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/chat_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ChatTextfield extends StatelessWidget {
  final _messageController = TextEditingController();
  final QueryDocumentSnapshot _queryDetails;

  ChatTextfield(this._queryDetails);

  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);

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
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'type your message...',
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TapDebouncer(
                      onTap: () async {
                        await _dbFirestore.sendChat(
                            toChat(_auth.getCurrentUser().uid),
                            _queryDetails,
                            _auth.getCurrentUser().uid);
                        _messageController.clear();
                      },
                      builder: (ctx, TapDebouncerFunc onTap) => IconButton(
                        icon: Icon(Icons.send),
                        onPressed: onTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(Icons.thumb_up),
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  toChat(String senderUid) {
    return Chat(
        text: _messageController.text,
        senderUid: senderUid,
        receiverUid: _queryDetails['poster_uid'],
        timestamp: Timestamp.now());
  }
}
