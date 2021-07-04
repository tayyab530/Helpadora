import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null ||
              snapshot.data.docs == [])
            return Center(
              child: CircularProgressIndicator(),
            );
          print('object');
          print(snapshot.data.docs.toString());
          return snapshot.data.docs == []
              ? Container()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    var _query = snapshot.data.docs[index];
                    return ConversationItem(
                      _query as QueryModel,
                      'last message',
                      Timestamp.now(),
                      [
                        _query.data()['sender_uid'],
                        _query.data()['receiver_uid']
                      ],
                      'w07VvGDU43ZtnBUYEzFeMbidgE33DOE1VdvV5xQzH9eq5aRnUQR68fl1',
                    );
                  },
                  itemCount: 2,
                );
        });
  }
}
