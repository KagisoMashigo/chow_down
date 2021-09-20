import 'package:chow_down/pages/home/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chow_down/pages/home/account/account_page.dart';
import 'package:chow_down/components/bottom_nav/cupertino_home_scaffold.dart';
import 'package:chow_down/pages/home/entries/entries_page.dart';
import 'package:chow_down/pages/home/jobs/jobs_page.dart';
import 'package:chow_down/components/bottom_nav/tab_item.dart';

class TabManager extends StatefulWidget {
  @override
  _TabManagerState createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.recipes: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => HomePage(),
      TabItem.recipes: (_) => JobsPage(),
      TabItem.search: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage()
    };
  }

  void _selectTab(TabItem tabItem) {
    // This allows you to pop back to (the home) of the currently selected tab
    if (tabItem == _currentTab) {
      // TODO: revview now that there os a new tab
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
