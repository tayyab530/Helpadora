import 'dart:async';

import 'package:helpadora/src/models/date_model.dart';

mixin class WriteQueryValidatorsMixin {
  titleValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.isNotEmpty)
        sink.add(value);
      else {
        sink.addError('Please Enter Title!');
      }
    });
  }

  descriptionValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.length > 6)
        sink.add(value);
      else {
        value.isEmpty
            ? sink.addError('Please Enter Description')
            : sink.addError('Description is too short!');
      }
    });
  }

  dueDateValidate() {
    return StreamTransformer<Date, Date>.fromHandlers(
        handleData: (Date value, sink) {
      if (value != null)
        sink.add(value);
      else {
        sink.addError('Please Enter Due Date');
      }
    });
  }

  locationValidate() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (String value, sink) {
      if (value.isNotEmpty) {
        sink.add(value);
      } else {
        sink.addError('Please Enter location');
      }
    });
  }
}
