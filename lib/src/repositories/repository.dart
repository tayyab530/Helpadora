import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/db_firestore_main.dart';
import 'package:helpadora/src/services/db_sqf_lite.dart';

class Repository with ChangeNotifier {
  final List<Source> _sources = <Source>[
    DbSqlLite(),
    DbFirestoreMain(),
  ];

  final List<Cache> _cache = <Cache>[
    DbSqlLite(),
  ];

  Future<List<QueryModel>> fetchPublicQueries(String uid) async {
    Source source;
    List<QueryModel> _queries = [];

    for (source in _sources) {
      _queries = await source.fetchPublicQueries(uid);
      print('fetch queries ${_queries.isEmpty}');
      if (_queries.isNotEmpty) {
        break;
      }
    }
    for (var cache in _cache) {
      print('enter in cache loop');
      if (source != cache as Source) {
        print('enter in cache if');
        var i = 0;
        for (QueryModel queryDoc in _queries) {
          await cache.cacheQuery(queryDoc);
          i++;
          print(i);
        }
        print('cached');
      }
    }
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    List<QueryModel> queries = await _sources[1].fetchSelfActiveQueries(uid);

    return queries;
  }

  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid) async {
    Source source;

    for (source in _sources) {
      List<QueryModel> queries = await source.fetchSelfSolvedQueries(uid);
      if (queries != null) return queries;
    }
    return null;
  }

  clearQueries(String uid) async {
    for (var cache in _cache) {
      await cache.clear();
    }
    await fetchPublicQueries(uid);
    await fetchSelfActiveQueries(uid);
    await fetchSelfSolvedQueries(uid);
  }

  Future<void> init() async {
    _sources.forEach((source) async {
      await source.init();
    });
    _cache.forEach((cache) async {
      await cache.init();
    });
  }
}

abstract class Source {
  Future<List<QueryModel>> fetchPublicQueries(String uid);
  Future<List<QueryModel>> fetchSelfActiveQueries(String uid);
  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid);
  Future<void> init();
}

abstract class Cache {
  Future<int> cacheQuery(QueryModel query);
  Future<int> clear();
  Future<void> init();
}
