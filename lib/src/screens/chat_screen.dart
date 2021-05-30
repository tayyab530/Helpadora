import 'package:flutter/material.dart';

import '../widgets/chat_textfield.dart';
import '../widgets/messages_list.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args['queryDetails']['title']),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 70.0),
        child: MessagesList(args['queryDetails']),
      ),
      bottomSheet: ChatTextfield(args['queryDetails']),
    );
  }
}
