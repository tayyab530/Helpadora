import 'package:flutter/material.dart';
import 'package:helpadora/src/constants/device_dimensions_info.dart';

import 'package:helpadora/src/widgets/tabs/conversation_tab.dart';
import 'package:helpadora/src/widgets/tabs/self_tab.dart';
import 'package:provider/provider.dart';
import '../widgets/tabs/community_tab.dart';
import '../widgets/tabs/conversation_tab.dart';
import '../widgets/tabs/settings_tab.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';
  final int initialTab;

  MainScreen({this.initialTab = 0});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final AppBar appBar = AppBar(
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
    );
    final appBarHeight = appBar.preferredSize.height;

    // ignore: unused_local_variable
    final _updateDeviceInfo =
        Provider.of<DeviceDimensionsInfo>(context, listen: false)
            .update(mediaQuery, appBarHeight);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: appBar,
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
