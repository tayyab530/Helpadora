import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:helpadora/src/models/query_model.dart';
import 'package:helpadora/src/repositories/repository.dart' as S;

class DbFirestoreMain with EquatableMixin implements S.Source {
  final _firestore = FirebaseFirestore.instance;
  final String name = 'firestore';

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
    return _queries;
  }

  Future<List<QueryModel>> fetchSelfActiveQueries(String uid) async {
    var queries = await _firestore
        .collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .get();

    List<QueryModel> _queries = [];
    print('fetch self active from fire');
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

    //logs
    print('fetch self solved from fire');

    queries.docs.forEach((query) {
      _queries.add(QueryModel.fromFirestore(query));
    });
    return _queries;
  }

  init() {
    return null;
  }

  @override
  List<Object> get props => [name];

  @override
  bool get stringify => true;
}
