import 'package:flutter/material.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:helpadora/src/widgets/conversation_item.dart';
import 'package:provider/provider.dart';

class OthersChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    return Text('data');
    // return StreamBuilder(
    //   stream: _dbFirestore.chatStream(qDetails, uid),
    //   builder: (context, snapshot) {
    //     return ListView.builder(
    //       itemBuilder: (context, index) {
    //         return ConversationItem(
    //             queryDetails, lastMessage, time, chatMembers, chatId);
    //       },
    //       itemCount: 2,
    //     );
    //   }
    // );
  }
}
