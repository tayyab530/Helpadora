import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:provider/provider.dart';

import 'list_of_chats_conversational.dart';
import '../services/auth_services.dart';
import '../services/db_firestore.dart';

class ListOfConversation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;

    return FutureBuilder(
      future: _dbFirestore.getQuriesList(uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting ||
            userSnapshot.data == null)
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 8.0,
            ),
          );
        else {
          List<QueryDocumentSnapshot> _listOfQuriesIds =
              userSnapshot.data.docs != null ? userSnapshot.data.docs : [];
          print(_listOfQuriesIds.toString());
          return _listOfQuriesIds == []
              ? Center(
                  child: Text('No chats!'),
                )
              : ListOfConversations(listOfQueries: _listOfQuriesIds, uid: uid);
        }
      },
    );
  }

  DateTime formatTimestamp(Timestamp timestamp) {
    return timestamp.toDate();
  }
}

class ListOfConversations extends StatelessWidget {
  ListOfConversations({
    @required this.listOfQueries,
    @required this.uid,
  });

  final List<QueryDocumentSnapshot> listOfQueries;
  final String uid;

  Widget build(context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...listOfQueries.map(
            (query) => FutureBuilder(
              future: _dbFirestore.querySnap(uid),
              builder: (context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (querySnapshot.connectionState == ConnectionState.waiting ||
                    querySnapshot.data == null) return Container();

                final _query = QueryModel.fromFirestore(
                  querySnapshot.data.docs.firstWhere(
                    (_query) => _query.id == _query.id,
                    orElse: () => null,
                  ),
                );

                return _query != null
                    ? ListOfChatsforConversation(_query)
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
