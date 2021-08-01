import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/repositories/repository.dart';
import 'package:provider/provider.dart';

import '../../screens/write_query_screen.dart';
import '../../services/auth_services.dart';
import '../list_of_queries.dart';
import '../list_of_queries_swapable.dart';

class SelfTab extends StatefulWidget {
  static const icon = HelpadoraIcons.pending;
  @override
  _MyQyeryTabState createState() => _MyQyeryTabState();
}

class _MyQyeryTabState extends State<SelfTab> {
  bool showSolvedQueries = false;
  @override
  Widget build(BuildContext context) {
    // final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final _repository = Provider.of<Repository>(context, listen: false);

    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          ListOfActiveQueries(
              deviceHeight, showSolvedQueries, _repository, _uid),
          BottomSlider(showSolvedQueries, toggleSlider),
          showSolvedQueries
              ? solvedQueriesList(deviceHeight, _repository, _uid)
              : Container(),
        ],
      ),
      // floatingActionButton: floatingActionButton(context),
    );
  }

  Container solvedQueriesList(
      double deviceHeight, Repository _repository, String uid) {
    return Container(
      height: (deviceHeight / 2) - 77,
      child: FutureBuilder(
        future: _repository.fetchSelfSolvedQueries(uid),
        builder: (ctx, AsyncSnapshot<List<QueryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return ListOfQueries(snapshot.data);
        },
      ),
    );
  }

  toggleSlider() {
    setState(() {
      showSolvedQueries = !showSolvedQueries;
    });
  }
}

class ListOfActiveQueries extends StatelessWidget {
  ListOfActiveQueries(
      this.deviceHeight, this.showSolvedQueries, this._repository, this.uid);

  final double deviceHeight;
  final bool showSolvedQueries;
  final Repository _repository;
  final String uid;

  Widget build(BuildContext context) {
    return Container(
      height: showSolvedQueries
          ? ((deviceHeight / 2) - 86)
          : ((deviceHeight - MediaQuery.of(context).padding.top) - 163),
      child: FutureBuilder(
        // stream: _repository.unsolvedQueryStream
        //     .where('poster_uid', isEqualTo: _auth.getCurrentUser().uid)
        //     .snapshots(),
        future: _repository.fetchSelfActiveQueries(uid),
        builder: (ctx, AsyncSnapshot<List<QueryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          return ListOfQueriesSwapable(snapshot.data);
        },
      ),
    );
  }
}

class BottomSlider extends StatelessWidget {
  BottomSlider(
    this.showSolvedQueries,
    this.toggleSlider,
  );

  final bool showSolvedQueries;
  final Function toggleSlider;

  Widget build(context) {
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
                onPressed: toggleSlider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
