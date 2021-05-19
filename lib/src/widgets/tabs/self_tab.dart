import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:helpadora/src/services/db_firestore.dart';
import 'package:helpadora/src/widgets/list_of_queries.dart';
import 'package:helpadora/src/widgets/list_of_queries_swapable.dart';
import 'package:provider/provider.dart';

class SelfTab extends StatefulWidget {
  @override
  _SelfTabState createState() => _SelfTabState();
}

class _SelfTabState extends State<SelfTab> {
  bool showSolvedQueries = false;
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context);
    final _auth = Provider.of<AuthService>(context);

    return Column(
      children: [
        Container(
          height: showSolvedQueries
              ? ((MediaQuery.of(context).size.height / 2) - 77)
              : ((MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top) -
                  154),
          child: StreamBuilder(
            stream:
                _dbFirestore.unsolvedQueryStream(_auth.getCurrentUser().uid),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              return ListOfQueriesSwapable(snapshot.data.docs);
            },
          ),
        ),
        Container(
          color: Colors.amber,
          height: 26.0,
          width: double.infinity,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Solved Queries '),
              FittedBox(
                fit: BoxFit.contain,
                child: IconButton(
                  icon: Icon(showSolvedQueries
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down),
                  onPressed: () {
                    setState(() {
                      showSolvedQueries = !showSolvedQueries;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        showSolvedQueries
            ? Container(
                height: (MediaQuery.of(context).size.height / 2) - 77,
                child: StreamBuilder(
                  stream: _dbFirestore
                      .solvedQueryStream(_auth.getCurrentUser().uid),
                  builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    return ListOfQueries(snapshot.data.docs);
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
