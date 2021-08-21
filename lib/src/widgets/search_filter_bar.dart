import 'package:flutter/material.dart';
import 'package:helpadora/src/constants/device_dimensions_info.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final List<QueryModel> _listOfQueries;

  SearchFilterBar(
    this._listOfQueries,
  );

  @override
  Widget build(BuildContext context) {
    final _iconTextColor = Colors.black;
    final _mediaQuery =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.symmetric(
        vertical: _mediaQuery.height * 0.005,
        horizontal: _mediaQuery.width * 0.02,
      ),
      height: _mediaQuery.height * 0.12,
      width: _mediaQuery.width,
      child: Row(
        children: [
          SearchField(
            iconTextColor: _iconTextColor,
            listOfQueries: _listOfQueries,
          ),
          Container(
            child: FilterDropdown(),
            width: _mediaQuery.width * 0.10,
          ),
        ],
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaQuery =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    return PopupMenuButton(
      icon: Padding(
        padding: EdgeInsets.only(right: _mediaQuery.width * 0.01),
        child: Icon(
          HelpadoraIcons.search_filters,
          size: _mediaQuery.width * 0.05,
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

class SearchField extends StatefulWidget {
  SearchField({
    @required this.iconTextColor,
    @required this.listOfQueries,
  });

  final Color iconTextColor;
  final List<QueryModel> listOfQueries;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController textController = TextEditingController();
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _queriesNotifier =
        Provider.of<QueriesNotifier>(context, listen: false);
    final _mediaQuery =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    return Container(
      width: _mediaQuery.width * 0.86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        focusNode: _focusNode,
        style: TextStyle(color: widget.iconTextColor),
        controller: textController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: widget.iconTextColor),
          hintText: 'Search....',
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: widget.iconTextColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              HelpadoraIcons.cross,
              color: widget.iconTextColor,
            ),
            onPressed: () {
              textController.clear();
              _queriesNotifier.setToNull();
            },
          ),
        ),
        onSubmitted: (text) {
          print(text);
          _queriesNotifier.searchQueries(text, widget.listOfQueries);
        },
        onTap: () {
          print('focus request');
          _focusNode.requestFocus();
        },
      ),
    );
  }
}
