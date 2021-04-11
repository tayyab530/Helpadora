import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage;
  // ignore: missing_return
  Future<User> registerWithEandP(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _auth.currentUser;
      if (result != null) {
        await result.user.sendEmailVerification();
        return result.user;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      return null;
    }
  }

  // ignore: missing_return
  Future<User> loginWithEandP(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result != null) {
        if(!result.user.emailVerified){
          _errorMessage = 'Email is not verified.Please verify then login again.';
          return null;
        }
        return result.user;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message;
      return null;
    }
  }

  Future<void> signOut() async => await _auth.signOut();
  

  String getError() => _errorMessage;

  User getCurrentUser() => _auth.currentUser;

  bool isLogedIn() {
    User _user = _auth.currentUser;
    if(_user != null && _user.emailVerified)
      return true;
    return false;
  }
}

