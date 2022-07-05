import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/conversation_item_model.dart';
import 'package:helpadora/src/models/conversation_item_model.dart';
import 'package:helpadora/src/models/message_model.dart';

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
        'list_of_queries': [],
        'email_address': user.emailAddress,
        'ratings': <double>[]
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
        'posted_time': query.postedTime,
      },
    ).then((_) =>
        _firestore.collection('user').doc(query.posterUid).update({
          'list_of_queries': FieldValue.arrayUnion([documentRef.id])
        }));
  }

  Future<void> deleteQuery(QueryModel query) async =>
      _firestore
          .collection('query')
          .doc(query.qid)
          .update({'isDeleted': true}).then(
            (value) =>
            _firestore.collection('user').doc(query.posterUid).update(
              {
                'list_of_queries': FieldValue.arrayRemove([query.qid])
              },
            ),
      );

  Future<void> solveQuery(String queryId, String solverUid,
      double rating) async =>
      _firestore.collection('query').doc(queryId).update(
        {
          'isSolved': true,
          'solver_uid': solverUid,
        },
      ).then(
            (_) =>
            _firestore.collection('user').doc(solverUid).update(
              {
                'ratings': FieldValue.arrayUnion(
                  [rating],
                ),
                'list_of_queries': FieldValue.arrayRemove([queryId]),
              },
            ),
      );

  Future<void> sendChat(Message message, QueryModel query,
      String senderUid) async {
    var _chatRef = _firestore
        .collection('chats')
        .doc(senderUid + query.posterUid + query.qid);

    bool _exists = !(await _chatRef.get()).exists;

    print(senderUid + query.posterUid);

    return _chatRef.collection('messages').doc().set({
      'sender_uid': message.senderUid,
      'receiver_uid': message.receiverUid,
      'text': message.text,
      'time': message.time,
    }).then((_) {
      _chatRef.set(
        {
          'last_message': message.text,
          'time': message.time,
          if (_exists) 'chat_members': [message.senderUid, message.receiverUid],
          if (_exists) 'qid': query.qid,
          if (_exists) 'sender_uid': message.senderUid,
          if (_exists) 'receiver_uid': message.receiverUid,
        },
        SetOptions(merge: true),
      );
    });
  }

  Query get publicQueryStream =>
      _firestore
          .collection('query')
          .where('isDeleted', isEqualTo: false)
          .where('isSolved', isEqualTo: false);

  Query get unsolvedQueryStream =>
      _firestore
          .collection('query')
          .where('isDeleted', isEqualTo: false)
          .where('isSolved', isEqualTo: false);

  Query get solvedQueryStream =>
      _firestore.collection('query').where('isSolved', isEqualTo: true);

  Stream<QuerySnapshot> meChatStream(QueryModel qDetails, String uid) {
    return _firestore
        .collection('chats')
        .doc(uid + qDetails.posterUid + qDetails.qid)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Future<List<ConversationItemModel>> otherChatStream(String uid) async {
    List<String> _queryIdList = [],
        _rUidList = [];
    List<ConversationItemModel> _filteredChats = [];
    QuerySnapshot _chats = await _firestore
        .collection('chats')
        .where('sender_uid', isEqualTo: uid)
        .get();
    print(_chats.docs.toString());
    _chats.docs.forEach((e) {
      String _qid = e.data()['qid'];
      String _rUid = e.data()['receiver_uid'];
      print('qid: $_qid');
      print("receiver_uid: $_rUid");
      _queryIdList.add(_qid);
      _rUidList.add(_rUid);
    });

    QuerySnapshot _querySnaps = await _firestore
        .collection('query')
        .where('poster_uid', whereIn: _rUidList)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .get();

    _querySnaps.docs.forEach((query) {
      print(query.id);
      QueryDocumentSnapshot _chat = _chats.docs.firstWhere(
            (chat) =>
        (chat.data()['qid'] == query.id &&
            chat.data()['receiver_uid'] == query.data()['poster_uid']),
        orElse: () => null,
      );
      if (_chat != null) {
        print(_chat.id);
        var _query = QueryModel.fromFirestore(query);
        print(_query.qid);
        ConversationItemModel _conversationItem =
        ConversationItemModel.fromFirestore(_chat, _query);
        print(_conversationItem.query.qid);
        _filteredChats.add(_conversationItem);
        _filteredChats.sort((b, a) => a.sentTime.compareTo(b.sentTime));
        print('chat added');
      }
    });

    print(_queryIdList.toString());
    print(_rUidList.toString());
    print(_filteredChats.toString());
    return _filteredChats;
  }

  Future<QuerySnapshot> getQuriesList(String uid) {
    var result = _firestore.collection('query')
        .where('poster_uid', isEqualTo: uid)
        .where('isDeleted', isEqualTo: false)
        .where('isSolved', isEqualTo: false)
        .get();
    return result;
  }

  Future<DocumentSnapshot> querySnap(String qid) async =>
      _firestore.collection('query').doc(qid).get();

  Stream<QuerySnapshot> queryChatStream(String qUid) {
    return _firestore
        .collection('chats')
        .where('qid', isEqualTo: qUid)
        .snapshots();
  }

  Stream<DocumentSnapshot> chatStreamWithID(String chatID) {
    return _firestore.collection('chats').doc(chatID).snapshots();
  }

  getChatsForRating(String queryId) {
    return _firestore
        .collection('query')
        .doc(queryId)
        .collection('chats')
        .get();
  }

  Future<DocumentSnapshot> getUserProfileData(String uid) {
    return _firestore.collection('user').doc(uid).get();
  }

  String checkPoster(String senderUid, String receiverUid, String posterUid) {
    if (senderUid == posterUid) {
      return receiverUid;
    } else
      return senderUid;
  }
}
