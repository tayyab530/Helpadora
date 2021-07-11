import 'package:sqflite/sqflite.dart';

import '../models/query_model.dart';
import '../repositories/repository.dart' show Cache, Source;

class DbSqlLite implements Cache, Source {
  Database _db;

  Future<List<QueryModel>> fetchPublicQueries(String uid) async {
    print('fetch from sqf');
    print(_db.path);
    var queries = await _db.query(
      'query',
      where: 'poster_uid != ? and isDeleted = ? and isSolved = ?',
      whereArgs: [uid, false, false],
    );
    List<QueryModel> _queries = [];

    queries.forEach((queryMap) {
      _queries.add(QueryModel.fromDbMap(queryMap));
    });
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    var _queriesAsMaps = [];
    List<QueryModel> _queries = [];
    print('fetchFromDb self');
    _queriesAsMaps = await _db.query('query',
        where: 'poster_uid = ? and isDeleted = ? and isSolved = ?',
        whereArgs: [uid, false, false]);
    print('fetched');
    print(_queriesAsMaps.toString());
    if (_queriesAsMaps.isNotEmpty || _queriesAsMaps != null) {
      print('data obtained');
      _queriesAsMaps.forEach(
        (queryMap) {
          print('adding...');
          _queries.add(
            QueryModel.fromDbMap(queryMap),
          );
        },
      );
    }
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid) {
    return null;
  }

  Future<int> cacheQuery(QueryModel query) async {
    var _cache = await _db.insert(
      'query',
      query.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return _cache;
  }

  Future<void> init() async {
    String path = await getDatabasesPath();
    String _dbPath = path + 'test5.db';
    _db = await openDatabase(
      _dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          """
            CREATE TABLE query 
            (
              qid TEXT PRIMARY KEY, 
              title TEXT, 
              poster_uid TEXT, 
              description TEXT, 
              due_date TEXT, 
              location TEXT, 
              posted_time TEXT, 
              isDeleted INTEGER, 
              isSolved INTEGER,
              solver_uid TEXT 
              )
              """,
        );

        print('onCreated callback');
      },
    );
  }

  Future<int> clear() async {
    return await _db.delete('query', where: null);
  }
}
