import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:provider/provider.dart';

import '../widgets/chat_textfield.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  final Map<String, dynamic> args;
  ChatScreen(this.args);

  @override
  Widget build(BuildContext context) {
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final QueryModel _queryDetails = args['queryDetails'];
    final Map<String, String> chatMembers = args['chatMembers'];

    final senderUid = _uid == _queryDetails.posterUid
        ? checkSenderUid(chatMembers, _uid)
        : _uid;
    final receiverUid = _uid == _queryDetails.posterUid
        ? checkSenderUid(chatMembers, _uid)
        : _queryDetails.posterUid;

    return Scaffold(
      appBar: AppBar(
        title: Text(_queryDetails.title),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 70.0),
        child: MessagesList(_queryDetails, senderUid),
      ),
      bottomSheet: ChatTextfield(
        _queryDetails,
        {'sender': senderUid, 'receiver': receiverUid},
      ),
    );
  }

  String checkSenderUid(Map<String, String> chatMembers, String currentUser) {
    if (chatMembers['sender_uid'] == currentUser)
      return chatMembers['receiver_uid']!;
    else
      return chatMembers['sender_uid']!;
  }
}
