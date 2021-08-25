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
    var tabBar = TabBar(
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
    );

    final AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text('Home'),
      bottom: tabBar,
    );

    var kappBarHeight = appBar.preferredSize.height;
    final _deviceInfo =
        Provider.of<DeviceDimensionsInfo>(context, listen: false);
    _deviceInfo.update(
      kappBarHeight,
      tabBar.preferredSize.height,
    );

    // ignore: unused_local_variable

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
