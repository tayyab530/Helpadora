import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/tabs/my_query_chat_tab.dart';
import 'package:helpadora/src/widgets/tabs/others_chats_tab.dart';

class ConversationTab extends StatelessWidget {
  static const String routeName = '/self_tab';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Container(
                child: Text('me'),
              ),
              Container(
                child: Text('others'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MeChatsTab(),
            OthersChatsTab(),
          ],
        ),
      ),
    );
  }
}
