import 'dart:async';

class LoginValidatorsMixin {
  emailValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.contains('@shu.edu.pk') || value.contains('@gmail.com'))
        sink.add(value);
      else {
        value.isEmpty
            ? sink.addError('Please Enter email!')
            : sink.addError('Please Enter a valid email!');
      }
    });
  }

  passwordValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.length > 5)
        sink.add(value);
      else {
        value.isEmpty
            ? sink.addError('Please Enter Password')
            : sink.addError('Please Enter at least 6 characters!');
      }
    });
  }
}
