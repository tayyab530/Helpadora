import 'package:flutter/material.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  final Map<String, bool> _filters;

  SearchFilterBar(
    this._filters,
  );
  @override
  Widget build(BuildContext context) {
    final _iconTextColor = Colors.black;

    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Row(
        children: [
          _searchField(_iconTextColor),
          Container(
            child: _filterDropdown(_filters),
            width: MediaQuery.of(context).size.width * 0.10,
          ),
        ],
      ),
    );
  }

  Widget _searchField(Color _iconTextColor) {
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
                },
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: _iconTextColor,
              ),
              onPressed: () {
                textController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(Map<String, bool> _filters) {
    return PopupMenuButton(
      icon: Icon(Icons.filter_list_rounded),
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
