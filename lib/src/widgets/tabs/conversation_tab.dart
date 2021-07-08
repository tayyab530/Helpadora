import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/widgets/tabs/my_query_chat_tab.dart';
import 'package:helpadora/src/widgets/tabs/others_chats_tab.dart';

class ConversationTab extends StatelessWidget {
  static const String routeName = '/self_tab';
  static const icon = HelpadoraIcons.chat;
  @override
  Widget build(BuildContext context) {
    return MeChatsTab();

    // return DefaultTabController(
    //   length: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       automaticallyImplyLeading: false,
    //       bottom: TabBar(
    //         tabs: [
    //           Container(
    //             child: Text('me'),
    //           ),
    //           Container(
    //             child: Text('others'),
    //           )
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         MeChatsTab(),
    //         OthersChatsTab(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
