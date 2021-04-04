import 'package:flutter/material.dart';

class PointsScreen extends StatelessWidget {
  static const routeName = '/points_screen';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Helper'),
      ),
      body: ListView(
        children: [
          Center(child: Text('List of chats')),
        ],
      ),
    );
  }
}
