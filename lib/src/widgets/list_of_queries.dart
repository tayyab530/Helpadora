import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'query_item.dart';

class ListOfQueries extends StatelessWidget {
  final List<QueryDocumentSnapshot> queries;

  ListOfQueries(this.queries);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 3.0),
      itemCount: queries.length,
      itemBuilder: (context, index) {
        return QueryItem(queries[index]);
      },
    );
  }
}
