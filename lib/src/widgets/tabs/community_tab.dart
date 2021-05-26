import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/write_query_screen.dart';
import '../../services/db_firestore.dart';
import '../list_of_queries.dart';

class CommunityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: _dbFirestore.publicQueryStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return ListOfQueries(snapshot.data.docs);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
