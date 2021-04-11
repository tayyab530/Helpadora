import 'package:flutter/foundation.dart';

class QueryModel {
  final String title;
  final String posterUid;
  final String description;
  final String dueDate;
  final String location;
  bool isDeleted;
  bool isSolved;
  String solverUid;

  QueryModel({
    @required this.title,
    @required this.posterUid,
    @required this.description,
    @required this.dueDate,
    @required this.location,
    this.isDeleted = false,
    this.isSolved = false,
    this.solverUid = '',
  });
}
