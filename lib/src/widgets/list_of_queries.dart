import 'package:flutter/material.dart';
import 'package:helpadora/src/models/query_model.dart';

import 'query_item.dart';

class ListOfQueries extends StatelessWidget {
  final List<QueryModel> queries;

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
