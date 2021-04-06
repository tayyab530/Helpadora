import 'dart:async';



class RegistrationValidatorMixin {
  userNameValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value != '')
        sink.add(value);
      else
        sink.addError('Please Enter User Name!');
    });
  }
}
