import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String userName;
  final String dob;
  final String gender;
  final String program;
  List<String> listOfQueries = [];

  UserModel({
    @required this.uid,
    @required this.userName,
    @required this.dob,
    @required this.gender,
    @required this.program,
  });
}
