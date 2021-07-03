import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpadora/src/repositories/repository.dart' as S;

class DbFirestoreMain implements S.Source {
  final _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> fetchPublicQueries(String uid) async {
    return await _firestore
        .collection('query')
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .where('poster_uid', isNotEqualTo: uid)
        .get();
  }

  Future<QuerySnapshot> fetchSelfActiveQueries(String uid) async {
    return await _firestore
        .collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .get();
  }

  Future<QuerySnapshot> fetchSelfSolvedQueries(String uid) async {
    return await _firestore
        .collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: true)
        .get();
  }
}
