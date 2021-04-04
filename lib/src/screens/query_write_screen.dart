import 'package:flutter/material.dart';

class WriteQuery extends StatelessWidget {
  static const routeName = '/write-query';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Your Query'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          titleField(),
          descriptionField(),
          dateTimeField(),
          locationField(context),
          postButton(context),
        ],
      ),
    );
  }

  Widget titleField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Title',
      ),
    );
  }

  Widget descriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Description',
      ),
      maxLines: 6,
      minLines: 2,
    );
  }

  Widget dateTimeField() {
    return Row(
      children: [
        Text('Due Date'),
        IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget locationField(BuildContext context) {
    return Row(
      children: [
        Text('Select Location'),
        PopupMenuButton(
          icon: Icon(Icons.expand_more),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Library'),
              ),
              PopupMenuItem(
                child: Text('CS Lab 1'),
              ),
              PopupMenuItem(
                child: Text('CS Lab 2'),
              ),
              PopupMenuItem(
                child: Text('CS Lab 3'),
              ),
            ];
          },
        ),
      ],
    );
  }

  Widget postButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).accentColor,
      ),
      onPressed: () {},
      child: Text('Post'),
    );
  }
}
