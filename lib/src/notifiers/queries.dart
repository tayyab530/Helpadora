import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Queries with ChangeNotifier {
  List<QueryDocumentSnapshot> _listOfQueries;

  List<QueryDocumentSnapshot> get listOfQueries => _listOfQueries;

  searchQueries(
      String _seachContent, List<QueryDocumentSnapshot> listOfQueries) {
    _listOfQueries = listOfQueries.where(
      (query) {
        // var _pattern = RegExp(r'[a-z]', caseSensitive: false);
        String _query =
            query.data()['title'] + '' + query.data()['description'];

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
