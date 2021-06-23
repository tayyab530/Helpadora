import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'package:helpadora/src/widgets/search_filter_bar.dart';
import 'package:provider/provider.dart';

import 'package:helpadora/src/services/auth_services.dart';
import '../../screens/write_query_screen.dart';
import '../../services/db_firestore.dart';
import '../list_of_queries.dart';

class CommunityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);
    final Map<String, bool> _filters = Provider.of<Filters>(context).filters;

    return Scaffold(
      body: StreamBuilder(
        stream: _dbFirestore.publicQueryStream
            .where('poster_uid', isNotEqualTo: _auth.getCurrentUser().uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // print("Length ${snapshot.data.docs.toString()}");
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          else {
            final _queriesNotifier = Provider.of<QueriesNotifier>(context);
            final _seachedQueries = _queriesNotifier.listOfQueries;
            var _listOfQueries =
                _seachedQueries != null ? _seachedQueries : snapshot.data.docs;

            return Column(
              children: [
                SearchFilterBar(_filters, _listOfQueries),
                Expanded(
                  child: ListOfQueries(
                    sortList(_listOfQueries, _filters),
                  ),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
        child: Icon(Icons.add),
      ),
    );
  }

  List<QueryDocumentSnapshot> sortList(
      List<QueryDocumentSnapshot> listOfQueries, Map<String, bool> _filters) {
    var _list = listOfQueries;
    if (_filters['title'])
      listOfQueries
          .sort((a, b) => a.data()['title'].compareTo(b.data()['title']));
    if (_filters['due_date'])
      listOfQueries
          .sort((a, b) => a.data()['due_date'].compareTo(b.data()['due_date']));
    if (_filters['location'])
      listOfQueries
          .sort((a, b) => a.data()['location'].compareTo(b.data()['location']));

    return _list;
  }
}
