import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

import '../../custom_icons/helpadora_icons.dart';
import 'my_query_chat_tab.dart';
import 'others_chats_tab.dart';

class ConversationTab extends StatelessWidget {
  static const String routeName = '/self_tab';
  static const icon = HelpadoraIcons.chat;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ShiftingTabBar(
          color: Colors.transparent,
          tabs: [
            ShiftingTab(
              icon: Icon(Icons.chat_bubble),
              text: 'me',
            ),
            ShiftingTab(
              icon: Icon(Icons.message),
              text: 'others',
            ),
          ],
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
