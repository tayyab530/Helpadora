import 'package:flutter/material.dart';
import 'package:helpadora/src/blocs/write_query_bloc.dart';
import 'package:helpadora/src/models/date_model.dart';
import 'package:provider/provider.dart';

class WriteQuery extends StatelessWidget {
  static const routeName = '/write-query';

  @override
  Widget build(BuildContext context) {
    final _wQueryBloc = Provider.of<WriteQueryBloc>(context);
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
          postButton(context, _wQueryBloc),
        ],
      ),
    );
  }

  Widget titleField(WriteQueryBloc _wqBloc) {
    return StreamBuilder(
        stream: _wqBloc.title,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              errorText: !snapshot.hasData ? snapshot.error : '',
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
              errorText: !snapshot.hasData ? snapshot.error : '',
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
              Text('Due Date'),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  var _pickedDate = await showDatePicker(
                    context: context,
                    initialDate: snapshot.data.pickedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day + 14),
                    currentDate: snapshot.data.currentDate,
                  );
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
              Text('Select Location'),
              PopupMenuButton(
                icon: Icon(Icons.expand_more),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: Locations.Library_1st_floor,
                      child: Text(_locationEnumToString(Locations.Library_1st_floor)),
                    ),
                    PopupMenuItem(
                      value: Locations.Library_2nd_floor,
                      child: Text(_locationEnumToString(Locations.Library_2nd_floor)),
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
                      child: Text(_locationEnumToString(Locations.CS_Lab_2)),
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

  Widget postButton(BuildContext context, WriteQueryBloc _wqBloc) {
    return StreamBuilder(
      stream: _wqBloc.post,
      builder: (context,AsyncSnapshot<bool> snapshot) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: snapshot.hasData ? Theme.of(context).accentColor: Colors.grey[350],
          ),
          onPressed: !snapshot.hasData ? null: () {
            
          },
          child: Text('Post'),
        );
      }
    );
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
