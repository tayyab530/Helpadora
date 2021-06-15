import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Queries with ChangeNotifier {
  List<QueryDocumentSnapshot> _listOfQueries;

  List<QueryDocumentSnapshot> get listOfQueries => _listOfQueries;

  searchQueries(
      String _seachContent, List<QueryDocumentSnapshot> listOfQueries) {
    _listOfQueries = listOfQueries
        .where(
          (query) => query.data()['title'].contains(_seachContent),
        )
        .toList();
    notifyListeners();
  }

  setToNull() {
    _listOfQueries = null;
    notifyListeners();
  }
}
