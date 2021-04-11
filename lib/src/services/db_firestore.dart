import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class DbFirestore with ChangeNotifier{
  final _firebase = FirebaseFirestore.instance;

  registerUserData(UserModel user) async {
    return await _firebase.collection('user').doc(user.uid).set(
      {
        'user_name': user.userName,
        'uid': user.uid,
        'dob': user.dob,
        'gender': user.gender,
        'program': user.program,
      },
    );
  }
}
