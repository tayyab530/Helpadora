import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/chat_model.dart';
import 'package:helpadora/src/models/conversation_item_model.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:helpadora/src/widgets/conversation_item.dart';
import 'package:provider/provider.dart';

class OthersChatsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    return FutureBuilder(
        future: _dbFirestore.otherChatStream(_uid),
        builder:
            (context, AsyncSnapshot<List<ConversationItemModel>> listOfChats) {
          if (listOfChats.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (!listOfChats.hasData){
            return Text('No chats');
          }
          return listOfChats.data == []
              ? Container()
              : ListView.builder(
                  itemCount: listOfChats.data!.length,
                  itemBuilder: (context, index) {
                    var _conversationItem = listOfChats.data![index];
                    return StreamBuilder(
                      stream: _dbFirestore
                          .chatStreamWithID(_conversationItem.chatID),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> chatSnap) {
                        if (chatSnap.connectionState ==
                                ConnectionState.waiting ||
                            !chatSnap.hasData)
                          return Center(child: CircularProgressIndicator());
                        Chat chatObj = Chat.fromFirestore(
                            chatSnap.data!, _conversationItem.query);
                        return ConversationItem(
                          _conversationItem.query,
                          chatObj.lastmessage,
                          chatObj.time,
                          _conversationItem.chatMembers,
                        );
                      },
                    );
                  },
                );
        });
  }
}
