import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final Map<String, bool> _filters;
  final List<QueryDocumentSnapshot> _listOfQueries;

  SearchFilterBar(
    this._filters,
    this._listOfQueries,
  );
  @override
  Widget build(BuildContext context) {
    final _iconTextColor = Colors.black;
    final _queriesNotifier =
        Provider.of<QueriesNotifier>(context, listen: false);

    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Row(
        children: [
          _searchField(_iconTextColor, _queriesNotifier, _listOfQueries),
          Container(
            child: _filterDropdown(_filters),
            width: MediaQuery.of(context).size.width * 0.10,
          ),
        ],
      ),
    );
  }

  Widget _searchField(Color _iconTextColor, QueriesNotifier _queriesNotifier,
      List<QueryDocumentSnapshot> _listOfQueries) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: _iconTextColor),
                controller: textController,
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: _iconTextColor),
                  hintText: 'Search....',
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: _iconTextColor,
                  ),
                ),
                onSubmitted: (value) {
                  print(value);
                  _queriesNotifier.searchQueries(value, _listOfQueries);
                },
              ),
            ),
            IconButton(
              icon: Icon(
                HelpadoraIcons.cross,
                color: _iconTextColor,
              ),
              onPressed: () {
                textController.clear();
                _queriesNotifier.setToNull();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(Map<String, bool> _filters) {
    return PopupMenuButton(
      icon: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Icon(
          HelpadoraIcons.search_filters,
          size: 15.0,
        ),
      ),
      onSelected: null,
      itemBuilder: (buildContext) {
        var filtersNotifier = Provider.of<Filters>(buildContext, listen: false);
        var _filters = filtersNotifier.filters;
        return [
          PopupMenuItem(
            value: 'due_date',
            child: Row(
              children: [
                Consumer<Filters>(
                  builder: (context, _filtersNotifier, child) {
                    return Checkbox(
                      value: _filtersNotifier.filters['due_date'],
                      onChanged: (value) {
                        print(value);
                        _filtersNotifier.filters['due_date'] = value;
                        _filtersNotifier.filters['title'] = false;
                        _filtersNotifier.filters['location'] = false;
                        filtersNotifier.updateFilter(_filters);
                      },
                    );
                  },
                ),
                Text('By due date'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'title',
            child: Row(
              children: [
                Consumer<Filters>(
                  builder: (context, _filtersNotifier, child) {
                    return Checkbox(
                      value: _filtersNotifier.filters['title'],
                      onChanged: (value) {
                        print(value);
                        _filtersNotifier.filters['title'] = value;
                        _filtersNotifier.filters['location'] = false;
                        _filtersNotifier.filters['due_date'] = false;
                        filtersNotifier.updateFilter(_filters);
                      },
                    );
                  },
                ),
                Text('By title'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'location',
            child: Row(
              children: [
                Consumer<Filters>(
                  builder: (context, _filtersNotifier, child) {
                    return Checkbox(
                      value: _filtersNotifier.filters['location'],
                      onChanged: (value) {
                        print(value);
                        _filtersNotifier.filters['location'] = value;
                        _filtersNotifier.filters['due_date'] = false;
                        _filtersNotifier.filters['title'] = false;
                        filtersNotifier.updateFilter(_filters);
                      },
                    );
                  },
                ),
                Text('By location'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
