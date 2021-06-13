import 'package:flutter/cupertino.dart';

class Filters with ChangeNotifier {
  Map<String, bool> _filters = {
    'due_date': false,
    'title': false,
    'location': false,
  };

  Map<String, bool> get filters => _filters;

  updateFilter(Map<String, bool> filters) {
    _filters = filters;
    notifyListeners();
  }
}
