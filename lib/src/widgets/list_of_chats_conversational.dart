import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

import 'conversation_item.dart';

class ListOfChatsforConversation extends StatefulWidget {
  final QueryModel query;
  ListOfChatsforConversation(this.query);

  @override
  _ListOfChatsforConversationState createState() =>
      _ListOfChatsforConversationState();
}

class _ListOfChatsforConversationState
    extends State<ListOfChatsforConversation> {
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
            : Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Chip(
                          label: Text(widget.query.title),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                        IconButton(
                          icon: Icon(!showChats
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up),
                          onPressed: () {
                            setState(() {
                              showChats = !showChats;
                            });
                          },
                        )
                      ],
                    ),
                    !showChats ? Container() : listOfChats(_chats)
                  ],
                ),
              );
      },
    );
  }

  Flexible listOfChats(List<QueryDocumentSnapshot> _chats) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 5.0),
        children: _chats
            .map((chat) => Column(
                  children: [
                    ConversationItem(
                      widget.query,
                      chat['last_message'],
                      chat['time'],
                      chat['chat_members'],
                      chat.id,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}

//TODO: uplift state to update whole screen