import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Auth {
  final auth;

  Auth(this.auth) {
    auth.createUserWithEmailAndPassword(
        email: 'mmtayyab530@gmail.com', password: '123456');
  }

  Future<FirebaseApp> initialize() async {
    return await Firebase.initializeApp();
  }
}
