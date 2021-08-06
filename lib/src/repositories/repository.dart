import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/services/db_firestore_main.dart';
import 'package:helpadora/src/services/db_sqf_lite.dart';

class Repository with ChangeNotifier {
  final List<Source> _sources = <Source>[
    DbSqlLite(),
    DbFirestoreMain(),
  ];

  final List<Cache> _caches = <Cache>[
    DbSqlLite(),
  ];

  Future<List<QueryModel>> fetchPublicQueries(String uid) async {
    Source source;
    Cache cache;
    List<QueryModel> _queries = [];

    for (source in _sources) {
      _queries = await source.fetchPublicQueries(uid);
      print('fetch queries ${_queries.isEmpty}');
      if (_queries.isNotEmpty) {
        for (cache in _caches) {
          print('enter in cache loop');
          if (source != cache) {
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
        break;
      }
    }
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    int i = 0;
    Source source;
    Cache cache;
    List<QueryModel> queries = [];

    for (source in _sources) {
      queries = await source.fetchSelfActiveQueries(uid);
      print(queries.length);
      if (queries.isNotEmpty) {
        for (cache in _caches) {
          if (source != cache) {
            print('caching...');
            queries.forEach(
              (query) async {
                i++;
                print(i);
                await cache.cacheQuery(query);
              },
            );
          }
        }
        break;
      }
    }
    return queries;
  }

  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid) async {
    int i = 0;
    Source source;
    Cache cache;
    List<QueryModel> queries = [];

    for (source in _sources) {
      queries = await source.fetchSelfSolvedQueries(uid);
      print(queries.length);
      if (queries.isNotEmpty) {
        for (cache in _caches) {
          if (source != cache) {
            print('caching...');
            queries.forEach(
              (query) async {
                i++;
                print(i);
                await cache.cacheQuery(query);
              },
            );
          }
        }
        break;
      }
    }
    return queries;
  }

  clearPublicQueries(String uid) async {
    for (var cache in _caches) {
      await cache.clear();
    }
    await fetchPublicQueries(uid);
  }

  clearActiveSelfQueries(String uid) async {
    for (var cache in _caches) {
      await cache.clear();
    }

    await fetchSelfActiveQueries(uid);
  }

  clearSolvedSelfQueries(String uid) async {
    for (var cache in _caches) {
      await cache.clear();
    }
    await fetchSelfSolvedQueries(uid);
  }

  Future<void> init() async {
    _sources.forEach((source) async {
      await source.init();
    });
    _caches.forEach((cache) async {
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
