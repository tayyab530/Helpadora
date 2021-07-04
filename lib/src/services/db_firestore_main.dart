import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/repositories/repository.dart' as S;

class DbFirestoreMain implements S.Source {
  final _firestore = FirebaseFirestore.instance;

  Future<List<QueryModel>> fetchPublicQueries(String uid) async {
    var queries = await _firestore
        .collection('query')
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .where('poster_uid', isNotEqualTo: uid)
        .get();
    List<QueryModel> _queries = [];
    print('fetch from firestore');
    queries.docs.forEach((querySnap) {
      var query = QueryModel.fromFirestore(querySnap);
      _queries.add(query);
    });
    return _queries == [] ? null : _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    var queries = await _firestore
        .collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .get();

    List<QueryModel> _queries = [];

    queries.docs.forEach((querySnap) {
      var query = QueryModel.fromFirestore(querySnap);
      _queries.add(query);
    });

    return _queries;
  }

  Future<List<QueryModel>> fetchSelfSolvedQueries(String uid) async {
    var queries = await _firestore
        .collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: true)
        .get();

    List<QueryModel> _queries = [];
    queries.docs.forEach((query) {
      _queries.add(QueryModel.fromFirestore(query));
    });
    return _queries;
  }

  init() {
    return null;
  }
}