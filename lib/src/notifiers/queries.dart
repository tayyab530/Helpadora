import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:helpadora/src/widgets/list_of_queries.dart';

class Queries with ChangeNotifier {
  List<QueryDocumentSnapshot> _listOfQueries;

  List<QueryDocumentSnapshot> get listOfQueries => _listOfQueries;

  searchQueries(String _seachContent) {
    _listOfQueries = _listOfQueries
        .where(
          (query) => query.data()['title'].contains(_seachContent),
        )
        .toList();
    notifyListeners();
  }
}
