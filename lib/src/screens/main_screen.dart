import 'package:flutter/material.dart';

import 'package:helpadora/src/widgets/tabs/conversation_tab.dart';
import 'package:helpadora/src/widgets/tabs/self_tab.dart';
import 'package:intl/intl.dart';
import '../widgets/tabs/community_tab.dart';
import '../widgets/tabs/conversation_tab.dart';
import '../widgets/tabs/settings_tab.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';
  final int initialTab;

  MainScreen({this.initialTab = 0});
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
                icon: Icon(
                  CommunityTab.icon,
                ),
              ),
              Tab(
                icon: Icon(SelfTab.icon),
              ),
              Tab(
                icon: Icon(
                  ConversationTab.icon,
                ),
              ),
              Tab(icon: Icon(SettingsTab.icon)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CommunityTab(),
            SelfTab(),
            ConversationTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}
