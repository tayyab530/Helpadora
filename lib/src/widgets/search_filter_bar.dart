import 'package:flutter/material.dart';
import 'package:helpadora/src/constants/device_dimensions_info.dart';
import 'package:helpadora/src/custom_icons/helpadora_icons.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/notifiers/filters.dart';
import 'package:helpadora/src/notifiers/queries.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final List<QueryModel> _listOfQueries;
  final Size _size;
  SearchFilterBar(
    this._listOfQueries,
    this._size,
  );

  @override
  Widget build(BuildContext context) {
    final _iconTextColor = Colors.black;
    // final _mediaQuery = MediaQuery.of(context).removePadding(removeTop: true);
    final _constants =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    final double height = (_size.height - _constants.kappBarHeight - 24.0);
    final double width = _size.width;
    // print('Search ' +
    //     (_constants.kappBarHeight + _constants.ktabBarHeight).toString());
    print((height));
    print(width);
    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.symmetric(
        vertical: height * 0.005,
        horizontal: width * 0.02,
      ),
      height: height * 0.12,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SearchField(
            iconTextColor: _iconTextColor,
            listOfQueries: _listOfQueries,
            width: width,
          ),
          FilterDropdown(_size.width),
        ],
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  FilterDropdown(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    // final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: width * 0.10,
      child: PopupMenuButton(
        icon: Padding(
          padding: EdgeInsets.only(right: width * 0.01),
          child: Icon(
            HelpadoraIcons.search_filters,
            size: width * 0.05,
          ),
        ),
        onSelected: null,
        itemBuilder: (buildContext) {
          var filtersNotifier =
              Provider.of<Filters>(buildContext, listen: false);
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
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  SearchField({
    @required this.iconTextColor,
    @required this.listOfQueries,
    @required this.width,
  });

  final Color iconTextColor;
  final double width;
  final List<QueryModel> listOfQueries;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _queriesNotifier =
        Provider.of<QueriesNotifier>(context, listen: false);
    // final _mediaQuery = MediaQuery.of(context).size;
    return Container(
      width: width * 0.86,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        style: TextStyle(color: iconTextColor),
        controller: textController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: iconTextColor),
          hintText: 'Search....',
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: iconTextColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              HelpadoraIcons.cross,
              color: iconTextColor,
            ),
            onPressed: () {
              textController.clear();
              _queriesNotifier.setToNull();
            },
          ),
        ),
        onSubmitted: (text) {
          print(text);
          _queriesNotifier.searchQueries(text, listOfQueries);
        },
      ),
    );
  }
}
