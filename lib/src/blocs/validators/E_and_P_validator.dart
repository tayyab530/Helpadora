import 'dart:async';

class EandPvalidatorsMixin {
  emailValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.contains('@shu.edu.pk'))
        sink.add(value);
      else
        sink.addError('Please Enter a valid email!');
    });
  }

  passwordValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.length > 5)
        sink.add(value);
      else
        sink.addError('Please Enter at least 6 characters!');
    });
  }
}
