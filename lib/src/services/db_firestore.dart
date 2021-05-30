import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/chat_model.dart';

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
        'list_of_quries': [],
      },
    );
  }

  Future<void> postQuery(QueryModel query) async {
    var documentRef = _firestore.collection('query').doc();
    return await documentRef.set(
      {
        'title': query.title,
        'description': query.description,
        'poster_uid': query.posterUid,
        'due_date': query.dueDate,
        'location': query.location,
        'isDeleted': query.isDeleted,
        'isSolved': query.isSolved,
        'solver_uid': query.solverUid,
        'list_of_chats': []
      },
    ).then((_) => _firestore.collection('user').doc(query.posterUid).update({
          'list_of_queries': FieldValue.arrayUnion([documentRef.id])
        }));
  }

  Future<void> deleteQuery(String queryId) async =>
      _firestore.collection('query').doc(queryId).update({'isDeleted': true});

  Future<void> solveQuery(String queryId) async =>
      _firestore.collection('query').doc(queryId).update({'isSolved': true});

  Future<void> sendChat(
      Chat chat, QueryDocumentSnapshot query, String uid) async {
    var _queryRef = _firestore.collection('query').doc(query.id);

    print(uid + query.data()['poster_uid']);

    return _queryRef
        .collection('chats')
        .doc(uid + query.data()['poster_uid'])
        .collection('messages')
        .doc()
        .set({
      'sender_uid': chat.senderUid,
      'receiver_uid': chat.receiverUid,
      'text': chat.text,
      'time': chat.timestamp
    });
  }

  Query get publicQueryStream => _firestore
      .collection('query')
      .where('isDeleted', isEqualTo: false)
      .where('isSolved', isEqualTo: false);

  Query get unsolvedQueryStream => _firestore
      .collection('query')
      .where('isDeleted', isEqualTo: false)
      .where('isSolved', isEqualTo: false);

  Query get solvedQueryStream =>
      _firestore.collection('query').where('isSolved', isEqualTo: true);

  Stream<QuerySnapshot> chatStream(QueryDocumentSnapshot qDetails, String uid) {
    return _firestore
        .collection('query')
        .doc(qDetails.id)
        .collection('chats')
        .doc(uid + qDetails.data()['poster_uid'])
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  String checkPoster(String senderUid, String receiverUid, String posterUid) {
    if (senderUid == posterUid) {
      return receiverUid;
    } else
      return senderUid;
  }
}
