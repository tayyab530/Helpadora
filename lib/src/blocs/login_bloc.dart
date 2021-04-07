import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'validators/E_and_P_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends ChangeNotifier with EandPvalidatorsMixin {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<bool> get submitForLog =>
      Rx.combineLatest2(email, password, (a, b) => true);

  Stream<String> get email => _email.stream.transform(emailValidate());
  Stream<String> get password => _password.stream.transform(passwordValidate());

  dispose() {
    super.dispose();
    _email.close();
    _password.close();
  }

  String getEmail() => _email.value;
  String getPassword() => _password.value;
}

//Please do not turn off the PC!!!!
