import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var app = await Firebase.initializeApp();

  runApp(App());
  Auth(FirebaseAuth.instance);
}

//TODO: Query Design Screen   done
