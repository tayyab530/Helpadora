import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/query_item.dart';

class ListOfQueries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return QueryItem();
      },
    );
  }
}
