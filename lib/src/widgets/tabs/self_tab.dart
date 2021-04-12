import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:helpadora/src/widgets/list_of_queries.dart';
import 'package:provider/provider.dart';

class SelfTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context);
    final _auth = Provider.of<AuthService>(context);

    return StreamBuilder(
        stream: _dbFirestore.personalQueryStream(_auth.getCurrentUser().uid),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          return ListOfQueries(snapshot.data.docs);
        });

    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text('Solved Queries'),
    //     IconButton(icon: Icon(Icons.expand_more), onPressed: () {}),
    //   ],
    // ),
  }
}
