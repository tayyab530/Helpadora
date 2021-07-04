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
    // final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final QueryModel _queryDetails = args['queryDetails'];
    final chatMembers = args['chatMembers'];

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
        args['chatMembers'],
        {'sender': senderUid, 'receiver': receiverUid},
      ),
    );
  }

  String checkSenderUid(List<dynamic> chatMembers, String currentUser) {
    if (chatMembers[0] == currentUser)
      return chatMembers[1];
    else
      return chatMembers[0];
  }
}
