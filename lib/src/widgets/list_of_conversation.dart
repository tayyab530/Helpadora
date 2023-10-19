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
          List<dynamic> _listOfQuriesIds = userSnapshot.data!.size > 0
              ? extractQUDfromMap(userSnapshot.data!.docs)
              : [];
          _listOfQuriesIds.forEach((element) {
            print('query id ' + element);
          });
          return _listOfQuriesIds.isEmpty
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

  List<dynamic> extractQUDfromMap(List<QueryDocumentSnapshot> listQDSS){
    List<dynamic> listOfQueries = [];
    listQDSS.forEach((query) {
      listOfQueries.add(query.id);
    });
    return listOfQueries;
  }
}

class ListOfConversations extends StatelessWidget {
  ListOfConversations({
    required this.listOfQueries,
    required this.uid,
  });

  final List<dynamic> listOfQueries;
  final String uid;

  Widget build(context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...listOfQueries.map(
            (queryId) => FutureBuilder(
              future: _dbFirestore.querySnap(queryId.toString()),
              builder:
                  (context, AsyncSnapshot<DocumentSnapshot> querySnapshot) {
                if (querySnapshot.connectionState == ConnectionState.waiting ||
                    !querySnapshot.hasData)
                  return Text('Loading...');
                else {
                  print('ID:' + queryId.toString());
                  print((querySnapshot.data!.data() as Map)['title'].toString());
                  final _query = QueryModel.fromFirestore(querySnapshot.data!);
                  print(listOfQueries.length);
                  return _query != null
                      ? ListOfConversationItem(
                          query: _query,
                        )
                      : Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
