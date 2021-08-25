import 'package:flutter/material.dart';
import 'package:helpadora/src/constants/device_dimensions_info.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/repositories/repository.dart';
import 'package:provider/provider.dart';

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
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final _constants =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    final _mediaQuery = MediaQuery.of(context).removePadding(removeTop: true);
    final _height = (_mediaQuery.size.height -
        _constants.kappBarHeight -
        (_mediaQuery.size.height * 0.038));
    print('selftab');
    print(_mediaQuery.size.height);
    print(_height);
    return Scaffold(
      body: Column(
        children: [
          ListOfActiveQueries(_height, showSolvedQueries, _uid),
          BottomSheet(showSolvedQueries, toggleSheet, _height),
          if (showSolvedQueries)
            SolvedQueriesList(
              _uid,
              _height,
            ),
        ],
      ),
      // floatingActionButton: floatingActionButton(context),
    );
  }

  toggleSheet() {
    setState(() {
      showSolvedQueries = !showSolvedQueries;
    });
  }
}

class ListOfActiveQueries extends StatelessWidget {
  ListOfActiveQueries(
    this.height,
    this.showSolvedQueries,
    this.uid,
  );

  final double height;
  final bool showSolvedQueries;
  final String uid;

  Widget build(BuildContext context) {
    final _repository = Provider.of<Repository>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await _repository.clearActiveSelfQueries(uid);
      },
      child: Container(
        height: showSolvedQueries ? (height * 0.54) : (height * 0.94),
        child: FutureBuilder(
          future: _repository.fetchSelfActiveQueries(uid),
          builder: (ctx, AsyncSnapshot<List<QueryModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null)
              return Center(child: CircularProgressIndicator());

            return ListOfQueriesSwapable(snapshot.data);
          },
        ),
      ),
    );
  }
}

class SolvedQueriesList extends StatelessWidget {
  SolvedQueriesList(
    this.uid,
    this.height,
  );
  final String uid;
  final double height;

  @override
  Widget build(BuildContext context) {
    final _repository = Provider.of<Repository>(context);

    return Container(
      height: height * 0.4,
      child: FutureBuilder(
        future: _repository.fetchSelfSolvedQueries(uid),
        builder: (ctx, AsyncSnapshot<List<QueryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.data.isEmpty) return Text('No Queries!');
          return ListOfQueries(snapshot.data);
        },
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  BottomSheet(
    this.showSolvedQueries,
    this.toggleSlider,
    this.height,
  );

  final bool showSolvedQueries;
  final Function toggleSlider;
  final double height;

  Widget build(context) {
    final _repository = Provider.of<Repository>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(10.0),
        topRight: const Radius.circular(10.0),
      ),
      child: Container(
        color: Theme.of(context).accentColor,
        height: (height * 0.06),
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
            IconButton(
              alignment: Alignment.center,
              onPressed: () async {
                await _repository.clearSolvedSelfQueries(_uid);
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ),
    );
  }
}
