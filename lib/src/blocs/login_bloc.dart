import 'dart:async';

import 'validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Object with LoginValidatorsMixin {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<bool> get submitForLog =>
      Rx.combineLatest2(email, password, (a, b) => true);

  Stream<String> get email => _email.stream.transform(emailValidate());
  Stream<String> get password => _password.stream.transform(passwordValidate());

  dispose() {
    _email.close();
    _password.close();
  }

  String getEmail() => _email.value;
  String getPassword() => _password.value;
}
