import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:helpadora/src/services/auth_services.dart';
import '../../screens/write_query_screen.dart';
import '../../services/db_firestore.dart';
import '../list_of_queries.dart';

class CommunityTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context);
    final _auth = Provider.of<AuthService>(context);

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
          else
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
