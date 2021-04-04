import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query Title'),
      ),
      body: Container(
        child: ListView(
          children: [
            Text('List of Chats'),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: TextField(
          decoration: InputDecoration(hintText: 'type your message...'),
        ),
      ),
    );
  }
}
