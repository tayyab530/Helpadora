import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/services/db_firestore_main.dart';

class Repository with ChangeNotifier {
  List<Source> _sources = <Source>[
    DbFirestoreMain(),
  ];

  Future<QuerySnapshot> fetchPublicQueries(String uid) async {
    Source source;
    QuerySnapshot _queries;

    for (source in _sources) {
      _queries = await source.fetchPublicQueries(uid);
      if (_queries != null) return _queries;
    }
    return null;
  }

  Future<QuerySnapshot> fetchSelfActiveQueries(String uid) async {
    Source source;

    for (source in _sources) {
      QuerySnapshot queries = await source.fetchSelfActiveQueries(uid);
      if (queries != null) return queries;
    }
    return null;
  }

  Future<QuerySnapshot> fetchSelfSolvedQueries(String uid) async {
    Source source;

    for (source in _sources) {
      QuerySnapshot queries = await source.fetchSelfSolvedQueries(uid);
      if (queries != null) return queries;
    }
    return null;
  }
}

abstract class Source {
  Future<QuerySnapshot> fetchPublicQueries(String uid);
  Future<QuerySnapshot> fetchSelfActiveQueries(String uid);
  Future<QuerySnapshot> fetchSelfSolvedQueries(String uid);
}
