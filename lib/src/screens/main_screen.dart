import 'package:flutter/material.dart';
import 'package:helpadora/src/widgets/list_of_queries.dart';
import 'package:helpadora/src/widgets/tabs/community_tab.dart';
import 'package:helpadora/src/widgets/tabs/self_tab.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

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
            CommunityTab(),
            SelfTab(),
            Text('CHAT'),
            Text('SET'),
          ],
        ),
      ),
    );
  }
}
