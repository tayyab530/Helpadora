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
    required this.qid,
    required this.title,
    required this.posterUid,
    required this.description,
    required this.dueDate,
    required this.location,
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
        title = (query.data()! as Map<String,dynamic>)['title'],
        posterUid = (query.data()! as Map<String,dynamic>)['poster_uid'],
        description = (query.data()! as Map<String,dynamic>)['description'],
        dueDate = (query.data()! as Map<String,dynamic>)['due_date'],
        location = (query.data()! as Map<String,dynamic>)['location'],
        isDeleted = (query.data()! as Map<String,dynamic>)['isDeleted'],
        isSolved = (query.data()! as Map<String,dynamic>)['isSolved'],
        solverUid = (query.data()! as Map<String,dynamic>)['solver_uid'],
        postedTime = Timestamp.now();

  QueryModel.fromDbMap(Map<String, Object?> queryMap)
      : qid = (queryMap as Map<String,dynamic>)['qid'] ,
        title = (queryMap as Map<String,dynamic>)['title'],
        posterUid = (queryMap as Map<String,dynamic>)['poster_uid'],
        description = (queryMap as Map<String,dynamic>)['description'],
        dueDate = (queryMap as Map<String,dynamic>)['due_date'],
        location = (queryMap as Map<String,dynamic>)['location'],
        isDeleted = (queryMap as Map<String,dynamic>)['isDeleted'] == 0 ? false : true,
        isSolved = (queryMap as Map<String,dynamic>)['isSolved'] == 0 ? false : true,
        solverUid = (queryMap as Map<String,dynamic>)['solver_uid'],
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
