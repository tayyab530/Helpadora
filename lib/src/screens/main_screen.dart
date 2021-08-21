import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/device_dimensions_info.dart';
import '../widgets/tabs/conversation_tab.dart';
import '../widgets/tabs/self_tab.dart';
import '../widgets/tabs/community_tab.dart';
import '../widgets/tabs/settings_tab.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';

  @override
  Widget build(BuildContext context) {
    print('main screen rebuild');
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
    final _mediaQuery = MediaQuery.of(context);
    // ignore: unused_local_variable
    final _updateDeviceInfo =
        Provider.of<DeviceDimensionsInfo>(context, listen: false)
            .update(_mediaQuery, appBarHeight);

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
