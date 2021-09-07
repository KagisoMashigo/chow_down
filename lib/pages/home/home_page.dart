import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/home/account/account_page.dart';
import 'package:time_tracker_flutter_course/pages/home/cupertino_home_scaffold.dart';
import 'package:time_tracker_flutter_course/pages/home/entries/entries_page.dart';
import 'package:time_tracker_flutter_course/pages/home/jobs/jobs_page.dart';
import 'package:time_tracker_flutter_course/pages/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage()
    };
  }

  void _selectTab(TabItem tabItem) {
    // This allows you to pop back to (the home) of the currently selected tab
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem].currentState.popUntil(
            (route) => route.isFirst,
          );
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        currentTab: _currentTab,
        onSelectedTab: _selectTab,
        widgetBuilders: widgetBuilders,
      ),
    );
  }
}
