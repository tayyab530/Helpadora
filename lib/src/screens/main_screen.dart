import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.people),
              ),
              Tab(
                icon: Icon(Icons.question_answer),
              ),
              Tab(
                icon: Icon(
                  Icons.pending,
                ),
              ),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text('CT'),
            Text('MQ'),
            Text('CHAT'),
            Text('SET'),
          ],
        ),
      ),
    );
  }
}
