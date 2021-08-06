import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/query_model.dart';
import '../../notifiers/filters.dart';
import '../../notifiers/queries.dart';
import '../../repositories/repository.dart';
import '../../widgets/search_filter_bar.dart';
import '../../custom_icons/helpadora_icons.dart';
import '../../services/auth_services.dart';
import '../../screens/write_query_screen.dart';
import '../list_of_queries.dart';

class CommunityTab extends StatelessWidget {
  static const icon = HelpadoraIcons.community;
  @override
  Widget build(BuildContext context) {
    // final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _uid =
        Provider.of<AuthService>(context, listen: false).getCurrentUser().uid;
    final Map<String, bool> _filters = Provider.of<Filters>(context).filters;
    final _repository = Provider.of<Repository>(context);

    return RefreshIndicator(
      onRefresh: () async => await _repository.clearPublicQueries(_uid),
      child: Scaffold(
        body: FutureBuilder(
          future: _repository.fetchPublicQueries(_uid),
          builder: (context, AsyncSnapshot<List<QueryModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null)
              return Center(child: CircularProgressIndicator());
            else {
              print('enter in community tab');

              final _queriesNotifier = Provider.of<QueriesNotifier>(context);
              final _seachedQueries = _queriesNotifier.listOfQueries;
              var _listOfQueries =
                  _seachedQueries != null ? _seachedQueries : snapshot.data;

              return Column(
                children: [
                  SearchFilterBar(_filters, _listOfQueries),
                  Expanded(
                    child: ListOfQueries(
                      sortList(_listOfQueries, _filters),
                    ),
                  ),
                ],
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
          child: CustomPaint(
            size: Size(21, 21),
            painter: AddIcon(),
          ),
        ),
      ),
    );
  }

  List<QueryModel> sortList(
      List<QueryModel> listOfQueries, Map<String, bool> _filters) {
    var _list = listOfQueries;
    if (_filters['title'])
      listOfQueries.sort((a, b) => a.title.compareTo(b.title));
    if (_filters['due_date'])
      listOfQueries.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    if (_filters['location'])
      listOfQueries.sort((a, b) => a.location.compareTo(b.location));

    return _list;
  }
}
