import 'dart:async';

import 'package:helpadora/src/models/date_model.dart';



mixin class RegistrationValidatorMixin {
  userNameValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value != '')
        sink.add(value);
      else
        sink.addError('Please Enter User Name!');
    });
  }

  genderValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value != '')
        sink.add(value);
      else
        sink.addError('Please Enter Gender!');
    });
  }

  dateValidate() {
    return StreamTransformer<Date, Date>.fromHandlers(
        handleData: (Date value, sink) {
      if (value != null)
        sink.add(value);
      else
        sink.addError('Please Enter Date!');
    });
  }

  programValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value != '')
        sink.add(value);
      else
        sink.addError('Please Enter Program!');
    });
  }
}
