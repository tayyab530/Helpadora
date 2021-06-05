import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'validators/login_validator.dart';
import 'validators/registration_fields_validator.dart';

class ChangePasswordBloc extends ChangeNotifier
    with RegistrationValidatorMixin, LoginValidatorsMixin {
  final _oldPassword = BehaviorSubject<String>();
  final _newPassword = BehaviorSubject<String>();
  final _retypePassword = BehaviorSubject<String>();

  Function(String) get changeOldPassword => _oldPassword.sink.add;
  Function(String) get changeNewPassword => _newPassword.sink.add;
  Function(String) get changeRetypePassword => _retypePassword.sink.add;

  Stream<bool> get resetPassword => Rx.combineLatest3(
      newPassword, retypePassword, oldPassword, (a, b, c) => true);

  Stream<String> get oldPassword =>
      _oldPassword.stream.transform(emailValidate());
  Stream<String> get newPassword =>
      _newPassword.stream.transform(passwordValidate());
  Stream<bool> get retypePassword => _validateConfirmPassword;

  Future dispose() async {
    super.dispose();

    await _oldPassword.close();
    await _newPassword.close();
    await _retypePassword.close();
  }

  drain() async {
    await _oldPassword.drain();
    await _newPassword.drain();
    await _retypePassword.drain();
  }

  String getOldPassword() => _oldPassword.value;
  String getNewPassword() => _newPassword.value;

  Stream<bool> get _validateConfirmPassword => Rx.combineLatest2(
        _newPassword,
        _retypePassword,
        (a, b) {
          if (((a != '') || (b != '')) && a == b) {
            return true;
          } else {
            _retypePassword.sink.addError('error');
            return false;
          }
        },
      );
}
