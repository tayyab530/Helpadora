import 'package:flutter/material.dart';
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
    final _queryDetails = args['queryDetails'];
    final chatMembers = args['chatMembers'];

    final senderUid = _uid == _queryDetails.data()['poster_uid']
        ? checkSenderUid(chatMembers, _uid)
        : _uid;
    final receiverUid = _uid == _queryDetails.data()['poster_uid']
        ? checkSenderUid(chatMembers, _uid)
        : _queryDetails.data()['poster_uid'];

    return Scaffold(
      appBar: AppBar(
        title: Text(args['queryDetails']['title']),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 70.0),
        child: MessagesList(args['queryDetails'], senderUid),
      ),
      bottomSheet: ChatTextfield(
        args['queryDetails'],
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
