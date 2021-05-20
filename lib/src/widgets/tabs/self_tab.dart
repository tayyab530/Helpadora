import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/write_query_screen.dart';
import '../../services/auth_services.dart';
import '../../services/db_firestore.dart';
import '../list_of_queries.dart';
import '../list_of_queries_swapable.dart';

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

    return Scaffold(
      body: Column(
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
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              color: Theme.of(context).accentColor,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
