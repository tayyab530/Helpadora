import 'package:flutter/material.dart';
import 'package:helpadora/src/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../blocs/write_query_bloc.dart';
import '../models/date_model.dart';
import '../screens/main_screen.dart';
import '../widgets/messages_popups.dart';
import '../services/db_firestore.dart';
import '../models/query_model.dart';

class WriteQuery extends StatelessWidget {
  static const routeName = '/write-query';
  final _underLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.blueAccent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final _wQueryBloc = Provider.of<WriteQueryBloc>(context, listen: false);
    final _dbFirestore = Provider.of<DbFirestore>(context, listen: false);
    final _auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Write Your Query'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          titleField(_wQueryBloc),
          descriptionField(_wQueryBloc),
          dateTimeField(context, _wQueryBloc),
          locationField(context, _wQueryBloc),
          postButton(context, _wQueryBloc, _dbFirestore, _auth),
        ],
      ),
    );
  }

  Widget titleField(WriteQueryBloc _wqBloc) {
    return StreamBuilder(
        stream: _wqBloc.title,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            maxLength: 30,
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: !snapshot.hasData ? snapshot.error.toString() : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: _wqBloc.changeTitle,
          );
        });
  }

  Widget descriptionField(WriteQueryBloc _wqBloc) {
    return StreamBuilder(
        stream: _wqBloc.description,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Description',
              errorText: !snapshot.hasData ? snapshot.error.toString() : '',
              errorBorder: _underLineBorder,
              focusedBorder: _underLineBorder,
              focusedErrorBorder: _underLineBorder,
            ),
            onChanged: _wqBloc.changeDescription,
            maxLines: 4,
            minLines: 2,
          );
        });
  }

  Widget dateTimeField(BuildContext context, WriteQueryBloc _wqBloc) {
    return StreamBuilder(
        initialData: Date(DateTime.now(), DateTime.now()),
        stream: _wqBloc.dueDate,
        builder: (context, AsyncSnapshot<Date> snapshot) {
          return Row(
            children: [
              Text('Due Date '),
              if (_wqBloc.getDueDate() != '')
                Chip(label: Text(_wqBloc.getDueDate())),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  var _pickedDate = await showDatePicker(
                    context: context,
                    initialDate: snapshot.data!.pickedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day + 14),
                    currentDate: snapshot.data!.currentDate,
                  );
                  if (_pickedDate != null)
                    _wqBloc.changeDueDate(Date(_pickedDate, _pickedDate));
                },
              ),
            ],
          );
        });
  }

  Widget locationField(BuildContext context, WriteQueryBloc _wqBloc) {
    return StreamBuilder(
        stream: _wqBloc.location,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Row(
            children: [
              Text('Select Location '),
              if (_wqBloc.getLocation() != '')
                Chip(label: Text(_wqBloc.getLocation())),
              PopupMenuButton(
                icon: Icon(Icons.expand_more),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: Locations.Library_1st_floor,
                      child: Text(
                          _locationEnumToString(Locations.Library_1st_floor)),
                    ),
                    PopupMenuItem(
                      value: Locations.Library_2nd_floor,
                      child: Text(
                          _locationEnumToString(Locations.Library_2nd_floor)),
                    ),
                    PopupMenuItem(
                      value: Locations.CS_Lab_1,
                      child: Text(_locationEnumToString(Locations.CS_Lab_1)),
                    ),
                    PopupMenuItem(
                      value: Locations.CS_Lab_2,
                      child: Text(_locationEnumToString(Locations.CS_Lab_2)),
                    ),
                    PopupMenuItem(
                      value: Locations.CS_Lab_3,
                      child: Text(_locationEnumToString(Locations.CS_Lab_3)),
                    ),
                  ];
                },
                onSelected: (Locations location) {
                  _wqBloc.changeLocation(
                    _locationEnumToString(location),
                  );
                },
              ),
            ],
          );
        });
  }

  Widget postButton(BuildContext context, WriteQueryBloc _wqBloc,
      DbFirestore _dbFirestore, AuthService _auth) {
    return StreamBuilder(
        stream: _wqBloc.post,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return TapDebouncer(
            onTap: !snapshot.hasData
                ? null
                : () async {
                    await _dbFirestore
                        .postQuery(QueryModel(
                          qid: '',
                          title: _wqBloc.getTitle(),
                          description: _wqBloc.getDescription(),
                          dueDate: _wqBloc.getDueDate(),
                          location: _wqBloc.getLocation(),
                          posterUid: _auth.getCurrentUser().uid,
                        ))
                        .then(
                          (value) => Dialogs.showConfirmationDialog(
                              context,
                              DialogMessages.queryPostingConfirm,
                              MainScreen.routeName),
                        );
                  },
            builder: (ctx, onTap) => TextButton(
              style: TextButton.styleFrom(
                backgroundColor: snapshot.hasData
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey[350],
              ),
              onPressed: onTap,
              child: Text(
                'Post',
                style: TextStyle(
                    color: Colors.black),
              ),
            ),
          );
        });
  }

  String _locationEnumToString(Locations location) {
    return location
        .toString()
        .replaceAllMapped('Locations.', (match) => '')
        .replaceAllMapped('_', (match) => ' ');
  }
}

enum Locations {
  Library_1st_floor,
  Library_2nd_floor,
  CS_Lab_1,
  CS_Lab_2,
  CS_Lab_3,
}
