import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

import '../models/query_model.dart';
import '../repositories/repository.dart' show Cache, Source;

class DbSqlLite with EquatableMixin implements Cache, Source {
  Database? _db;
  final String name = 'sqfLite';

  Future<List<QueryModel>> fetchPublicQueries(String uid) async {
    print(_db!.path);
    print('fetch from sqf');

    List<QueryModel> _queries = [];

    var _queriesAsMaps = await _db!.query(
      'query',
      where: 'poster_uid != ? and isDeleted = ? and isSolved = ?',
      whereArgs: [uid, 0, 0],
    );

    _queriesAsMaps.forEach((queryMap) {
      _queries.add(QueryModel.fromDbMap(queryMap));
    });
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    var _queriesAsMaps = [];
    List<QueryModel> _queries = [];
    print('fetchFromDb self active');
    _queriesAsMaps = await _db!.query(
      'query',
      where: 'poster_uid = ? and isDeleted = ? and isSolved = ?',
      whereArgs: [uid, 0, 0],
    );
    print('fetched');
    print(_queriesAsMaps.isEmpty);
    if (_queriesAsMaps.isNotEmpty) {
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

  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid) async {
    var _queriesAsMaps = [];
    List<QueryModel> _queries = [];
    print('fetchFromDb self solved');
    _queriesAsMaps = await _db!.query(
      'query',
      where: 'poster_uid = ? and isDeleted = ? and isSolved = ?',
      whereArgs: [uid, 0, 1],
    );
    print('fetched');
    print('query empty' + _queriesAsMaps.isEmpty.toString());
    if (_queriesAsMaps.isNotEmpty) {
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

  Future<int> cacheQuery(QueryModel query) async {
    var _cache = await _db!.insert(
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
    return await _db!.delete('query', where: null);
  }

  @override
  List<Object> get props => [name];

  @override
  bool get stringify => true;
}
