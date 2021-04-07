import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'validators/login_validator.dart';
import 'validators/registration_fields_validator.dart';

class RegistrationBloc extends ChangeNotifier
    with RegistrationValidatorMixin, LoginValidatorsMixin {
  final _userName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _createPassword = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _createPassword.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(String) get changeUserName => _userName.sink.add;

  Stream<bool> get submitForLog => Rx.combineLatest4(
      email, password, confirmPassword, userName, (a, b, c, d) => true);

  Stream<String> get email => _email.stream.transform(emailValidate());
  Stream<String> get password =>
      _createPassword.stream.transform(passwordValidate());
  Stream<bool> get confirmPassword =>
      Rx.combineLatest2(_createPassword, _confirmPassword, (a, b) {
        if (((a != '') || (a != '')) && a == b)
          return true;
        else
          return false;
      });
  Stream<String> get userName => _userName.stream.transform(userNameValidate());

  dispose() {
    super.dispose();
    _userName.close();
    _email.close();
    _createPassword.close();
    _confirmPassword.close();
  }

  String getEmail() => _email.value;
  String getPassword() => _createPassword.value;
}
