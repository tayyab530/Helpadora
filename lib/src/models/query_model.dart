import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class QueryModel {
  final String qid;
  final String title;
  final String posterUid;
  final String description;
  final String dueDate;
  final String location;
  final Timestamp postedTime;
  bool isDeleted;
  bool isSolved;
  String solverUid;

  QueryModel({
    @required this.qid,
    @required this.title,
    @required this.posterUid,
    @required this.description,
    @required this.dueDate,
    @required this.location,
    this.isDeleted = false,
    this.isSolved = false,
    this.solverUid = '',
  }) : this.postedTime = Timestamp.now();

  Map<String, Object> toMap() {
    return {
      "qid": qid,
      "title": title,
      "poster_uid": posterUid,
      "description": description,
      "due_date": dueDate,
      "location": location,
      "posted_time": postedTime.toDate().toString(),
      "isDeleted": isDeleted ? 1 : 0,
      "isSolved": isSolved ? 1 : 0,
      "solver_uid": solverUid == '' ? ' ' : solverUid,
    };
  }

  QueryModel.fromFirestore(DocumentSnapshot query)
      : qid = query.id,
        title = query.data()['title'],
        posterUid = query.data()['poster_uid'],
        description = query.data()['description'],
        dueDate = query.data()['due_date'],
        location = query.data()['location'],
        isDeleted = query.data()['isDeleted'],
        isSolved = query.data()['isSolved'],
        solverUid = query.data()['solver_uid'],
        postedTime = Timestamp.now();

  QueryModel.fromDbMap(Map<String, Object> queryMap)
      : qid = queryMap['qid'],
        title = queryMap['title'],
        posterUid = queryMap['poster_uid'],
        description = queryMap['description'],
        dueDate = queryMap['due_date'],
        location = queryMap['location'],
        isDeleted = queryMap['isDeleted'] == 0 ? false : true,
        isSolved = queryMap['isSolved'] == 0 ? false : true,
        solverUid = queryMap['solver_uid'],
        postedTime = Timestamp.now();

  toString() {
    return """ 
      qid $qid,
      title $title,
      posterUid $posterUid,
      description $description,
      dueDate $dueDate,
      location $location,
      postedTime $postedTime,
      isDeleted $isDeleted,
      isSolved $isSolved,
      solverUid $solverUid,
    """;
  }
}
