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
                        var text = _messageController.text;

                        _messageController.clear();
                        await _dbFirestore.sendChat(
                            toChat(_uid, text, receiverUid),
                            _queryDetails,
                            senderUid);
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

  toChat(String senderUid, String text, String rUid) {
    return Chat(
        text: text,
        senderUid: senderUid,
        receiverUid: rUid,
        timestamp: Timestamp.now());
  }
}
