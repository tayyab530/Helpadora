import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

import 'validators/login_validator.dart';
import 'validators/registration_fields_validator.dart';
import '../models/date_model.dart';

class RegistrationBloc extends ChangeNotifier
    with RegistrationValidatorMixin, LoginValidatorsMixin {
  final _userName = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _createPassword = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();
  final _gender = BehaviorSubject<String>();
  final _dob = BehaviorSubject<Date>();
  final _program = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _createPassword.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;
  Function(String) get changeUserName => _userName.sink.add;
  Function(String) get changeGender => _gender.sink.add;
  Function(Date) get changeDate => _dob.sink.add;
  Function(String) get changeProgram => _program.sink.add;

  Stream<bool> get submitForReg => Rx.combineLatest7(
      email,
      password,
      confirmPassword,
      userName,
      gender,
      date,
      program,
      (a, b, c, d, e, f, g) => true);

  Stream<String> get email => _email.stream.transform(emailValidate());
  Stream<String> get password =>
      _createPassword.stream.transform(passwordValidate());
  Stream<bool> get confirmPassword => _validateConfirmPassword;

  Stream<String> get userName => _userName.stream.transform(userNameValidate());
  Stream<String> get gender => _gender.stream.transform(genderValidate());
  Stream<Date> get date => _dob.stream.transform(dateValidate());
  Stream<String> get program => _program.stream.transform(programValidate());

  Future dispose() async {
    super.dispose();
    await _userName.close();
    await _email.close();
    await _createPassword.close();
    await _confirmPassword.close();
    await _gender.close();
    await _dob.close();
    await _program.close();
  }

  drain() async {
    await _userName.drain();
    await _email.drain();
    await _createPassword.drain();
    await _confirmPassword.drain();
    await _gender.drain();
    await _dob.drain();
    await _program.drain();
    await gender.drain();
    await date.drain();
    await program.drain();
  }

  String getEmail() => _email.value;
  String getPassword() => _createPassword.value;
  String getUserName() => _userName.value;
  String getGender() => _gender.value;
  String getProgram() => _program.value;
  String getDob() => DateFormat('MM dd yyyy').format(_dob.value.pickedDate);

  Stream<bool> get _validateConfirmPassword =>
      Rx.combineLatest2(_createPassword, _confirmPassword, (a, b) {
        if (((a != '') || (b != '')) && a == b) {
          return true;
        }
        else{
          _confirmPassword.sink.addError('error');
          return false;
        }
        
      });
}
