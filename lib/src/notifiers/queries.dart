import 'package:flutter/foundation.dart';
import 'package:helpadora/src/models/query_model.dart';

class QueriesNotifier with ChangeNotifier {
  List<QueryModel> _listOfQueries;

  List<QueryModel> get listOfQueries => _listOfQueries;

  searchQueries(String _seachContent, List<QueryModel> listOfQueries) {
    _listOfQueries = listOfQueries.where(
      (query) {
        // var _pattern = RegExp(r'[a-z]', caseSensitive: false);
        String _query = query.title + '' + query.description;

        return _query.toLowerCase().contains(_seachContent.toLowerCase());
      },
    ).toList();
    notifyListeners();
  }

  setToNull() {
    _listOfQueries = null;
    notifyListeners();
  }
}
