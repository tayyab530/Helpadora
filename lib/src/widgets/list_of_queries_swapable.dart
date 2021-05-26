import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:provider/provider.dart';

import 'query_item.dart';

class ListOfQueriesSwapable extends StatelessWidget {
  final List<QueryDocumentSnapshot> queries;

  ListOfQueriesSwapable(this.queries);

  @override
  Widget build(BuildContext context) {
    final _db = Provider.of<DbFirestore>(context);
    return ListView.builder(
      itemCount: queries.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(queries[index].id),
          child: QueryItem(
            queries[index],
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              _db.deleteQuery(queries[index].id);
            } else if (direction == DismissDirection.startToEnd) {
              _db.solveQuery(queries[index].id);
            }
          },
          background: Container(
            color: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            margin: EdgeInsets.only(bottom: 10.0),
            alignment: AlignmentDirectional.centerStart,
            child: Icon(Icons.fact_check),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
            margin: EdgeInsets.only(bottom: 10.0),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
