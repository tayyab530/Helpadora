import 'package:flutter/material.dart';

import 'write_query_screen.dart';
import '../widgets/tabs/community_tab.dart';
import '../widgets/tabs/self_tab.dart';
import '../widgets/tabs/settings_tab.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            SettingsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, WriteQuery.routeName),
          child: Icon(Icons.add),
        ),
        
      ),
    );
  }
}
