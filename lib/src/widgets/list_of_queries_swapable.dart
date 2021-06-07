import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/models/dialog_messages.dart';
import 'package:provider/provider.dart';

import '../services/db_firestore.dart';
import 'query_item.dart';
import 'message_Popup.dart';

class ListOfQueriesSwapable extends StatelessWidget {
  final List<QueryDocumentSnapshot> queries;

  ListOfQueriesSwapable(this.queries);

  @override
  Widget build(BuildContext context) {
    final _db = Provider.of<DbFirestore>(context, listen: false);
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8.0),
      itemCount: queries.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(queries[index].id),
          child: QueryItem(
            queries[index],
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              _db.deleteQuery(queries[index]);
            } else if (direction == DismissDirection.startToEnd) {
              // _db.solveQuery(queries[index].id);
            }
          },
          // ignore: missing_return
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.endToStart)
              return await Dialogs.alertDialogForQuery(
                  context,
                  DialogMessages.queryDeleteConfirm,
                  ['Delete', 'Cancel'],
                  Theme.of(context).errorColor);
            else if (direction == DismissDirection.startToEnd)
              return await Dialogs.alertDialogForQuerySolve(
                  context,
                  queries[index],
                  DialogMessages.querySolveConfirm,
                  ['Proceed', 'No'],
                  Colors.green);
          },
          background: SolvedBG(),
          secondaryBackground: DeleteBG(),
        );
      },
    );
  }
}

class DeleteBG extends StatelessWidget {
  const DeleteBG({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).errorColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
      margin: EdgeInsets.only(bottom: 20.0, top: 3.0),
      alignment: AlignmentDirectional.centerEnd,
      child: Icon(Icons.delete),
    );
  }
}

class SolvedBG extends StatelessWidget {
  const SolvedBG({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
      margin: EdgeInsets.only(bottom: 20.0, top: 3.0),
      alignment: AlignmentDirectional.centerStart,
      child: Icon(Icons.fact_check),
    );
  }
}
