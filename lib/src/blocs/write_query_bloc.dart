import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:helpadora/src/models/date_model.dart';
import 'package:intl/intl.dart';

import 'validators/write_query_validator.dart';
import 'package:rxdart/rxdart.dart';

class WriteQueryBloc extends ChangeNotifier with WriteQueryValidatorsMixin{
  final _title = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _dueDate = BehaviorSubject<Date>();
  final _location = BehaviorSubject<String>();

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(Date) get changeDueDate => _dueDate.sink.add;
  Function(String) get changeLocation => _location.sink.add;

  Stream<bool> get post => Rx.combineLatest4(title, description,dueDate,location ,(a, b, c, d) => true);

  Stream<String> get title => _title.stream.transform(titleValidate());
  Stream<String> get description =>
      _description.stream.transform(descriptionValidate());
  Stream<Date> get dueDate => _dueDate.stream.transform(dueDateValidate());      
  Stream<String> get location => _location.stream.transform(locationValidate());

  dispose() {
    super.dispose();
    _title.close();
    _description.close();
    _dueDate.close();
    _location.close();
  }

  drain() {
    _title.drain();
    _description.close();
    _dueDate.drain();
    _location.drain();
  }

  String getTitle() => _title.value;
  String getDescription() => _description.value;
  String getDueDate() => DateFormat('MM dd yyyy').format(_dueDate.value.pickedDate); 
  String getLocation() => _location.value;
}

//Please do not turn off the PC!!!!
