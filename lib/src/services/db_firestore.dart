import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import '../models/query_model.dart';

class DbFirestore with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  registerUserData(UserModel user) async {
    return await _firestore.collection('user').doc(user.uid).set(
      {
        'user_name': user.userName,
        'uid': user.uid,
        'dob': user.dob,
        'gender': user.gender,
        'program': user.program,
      },
    );
  }

  Future<void> postQuery(QueryModel query) async {
    return await _firestore.collection('query').doc().set(
      {
        'title': query.title,
        'description': query.description,
        'poster_uid': query.posterUid,
        'due_date': query.dueDate,
        'location': query.location,
        'isDeleted': query.isDeleted,
        'isSolved': query.isSolved,
        'solver_uid': query.solverUid,
      },
    );
  }

  Future<void> deleteQuery(String queryId) async {
    return await _firestore.collection('query').doc(queryId).delete();
  }

  Stream<QuerySnapshot> get publicQueryStream => _firestore
      .collection('query')
      .where('isDeleted', isEqualTo: false)
      .where('isSolved', isEqualTo: false)
      .snapshots();

  Stream<QuerySnapshot> personalQueryStream(String uid) {
    print(uid);
    return _firestore
        .collection('query')
        .where('isDeleted', isEqualTo: false)
        .where('poster_uid', isEqualTo: uid)
        .snapshots();
  }
}
