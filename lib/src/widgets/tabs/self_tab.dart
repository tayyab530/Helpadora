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
  _MyQyeryTabState createState() => _MyQyeryTabState();
}

class _MyQyeryTabState extends State<SelfTab> {
  bool showSolvedQueries = false;
  @override
  Widget build(BuildContext context) {
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context, listen: false);

    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          _listOfActiveQueries(deviceHeight, context, _dbFirestore, _auth),
          bottomSlider(context),
          showSolvedQueries
              ? solvedQueriesList(deviceHeight, _dbFirestore, _auth)
              : Container(),
        ],
      ),
      // floatingActionButton: floatingActionButton(context),
    );
  }

  Container _listOfActiveQueries(double deviceHeight, BuildContext context,
      DbFirestore _dbFirestore, AuthService _auth) {
    return Container(
      height: showSolvedQueries
          ? ((deviceHeight / 2) - 86)
          : ((deviceHeight - MediaQuery.of(context).padding.top) - 163),
      child: StreamBuilder(
        stream: _dbFirestore.unsolvedQueryStream
            .where('poster_uid', isEqualTo: _auth.getCurrentUser().uid)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return ListOfQueriesSwapable(snapshot.data.docs);
        },
      ),
    );
  }

  ClipRRect bottomSlider(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10.0),
        topRight: const Radius.circular(10.0),
      ),
      child: Container(
        color: Theme.of(context).accentColor,
        height: 35.0,
        width: double.infinity,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Solved Queries '),
            FittedBox(
              fit: BoxFit.contain,
              child: IconButton(
                icon: Icon(!showSolvedQueries
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
    );
  }

  Container solvedQueriesList(
      double deviceHeight, DbFirestore _dbFirestore, AuthService _auth) {
    return Container(
      height: (deviceHeight / 2) - 77,
      child: StreamBuilder(
        stream: _dbFirestore.solvedQueryStream
            .where('poster_uid', isEqualTo: _auth.getCurrentUser().uid)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return ListOfQueries(snapshot.data.docs);
        },
      ),
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
      child: Icon(Icons.add),
    );
  }
}
