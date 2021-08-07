import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

import 'conversation_item.dart';

class ListOfConversationItem extends StatefulWidget {
  final QueryModel query;
  ListOfConversationItem({
    @required this.query,
  });

  @override
  _ListOfConversationItemState createState() => _ListOfConversationItemState();
}

class _ListOfConversationItemState extends State<ListOfConversationItem> {
  bool showChats = true;

  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    return StreamBuilder(
      stream: _dbFirestore.queryChatStream(widget.query.qid),
      builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting ||
            chatSnapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          );

        final _chats = chatSnapshot.data.docs;
        print(_chats.toString());
        return _chats.isEmpty
            ? Container()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                        label: Text(
                          widget.query.title,
                          overflow: TextOverflow.fade,
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                      IconButton(
                          icon: Icon(!showChats
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up),
                          onPressed: toggleShowChats),
                    ],
                  ),
                  if (showChats) ...listOfChats(_chats),
                ],
              );
      },
    );
  }

  List<Widget> listOfChats(List<QueryDocumentSnapshot> _chats) {
    return _chats
        .map(
          (chat) => ConversationItem(
            widget.query,
            chat['last_message'],
            chat['time'],
            chat['chat_members'],
            chat.id,
          ),
        )
        .toList();
  }

  toggleShowChats() {
    setState(
      () {
        showChats = !showChats;
      },
    );
  }
}

//TODO: uplift state to update whole screen