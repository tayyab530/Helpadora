import 'package:flutter/material.dart';
import 'package:helpadora/src/models/theme_data.dart';
import 'package:provider/provider.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final _isLight = Provider.of<ThemeNotifier>(context, listen: false).isLight;
    final _iconTextColor = Colors.black;

    return Container(
      color: Theme.of(context).dividerColor,
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Row(
        children: [
          _searchField(_iconTextColor),
          Container(
            child: _filterDropdown(),
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

  Widget _filterDropdown() {
    return PopupMenuButton(
      icon: Icon(Icons.filter_list_rounded),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {
                    print(value);
                  },
                ),
                Text('By due date'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
