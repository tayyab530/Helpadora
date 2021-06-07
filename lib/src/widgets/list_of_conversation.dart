import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'list_of_chats_conversational.dart';
import '../services/auth_services.dart';
import '../services/db_firestore.dart';

class ListOfConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;

    return FutureBuilder(
        future: _dbFirestore.getQuriesList(_uid),
        builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting ||
              userSnapshot.data == null)
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 8.0,
              ),
            );
          else {
            List<dynamic> _listOfQuries =
                userSnapshot.data.data()['list_of_queries'] != null
                    ? userSnapshot.data.data()['list_of_queries']
                    : [];
            print(_listOfQuries.toString());
            return _listOfQuries == []
                ? Center(
                    child: Text('No chats!'),
                  )
                : listOfConversations(_listOfQuries, _dbFirestore, _uid);
          }
        });
  }

  Container listOfConversations(
      List _listOfQuries, DbFirestore _dbFirestore, String _uid) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ..._listOfQuries.map(
            (queryId) => FutureBuilder(
              future: _dbFirestore.querySnap(_uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (querySnapshot.connectionState == ConnectionState.waiting ||
                    querySnapshot.data == null) return Container();

                final querySnap = querySnapshot.data.docs.firstWhere(
                  (query) => query.id == queryId,
                  orElse: () => null,
                );

                return querySnap != null
                    ? ListOfChatsforConversation(queryId, querySnap)
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  DateTime formatTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}
