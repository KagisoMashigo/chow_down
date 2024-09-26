// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/bottom_nav/cupertino_home_scaffold.dart';
import 'package:chow_down/components/bottom_nav/tab_item.dart';
import 'package:chow_down/pages/account/account_page.dart';
import 'package:chow_down/pages/home/home_page.dart';
import 'package:chow_down/pages/recipes/saved_recipe_page.dart';
import 'package:chow_down/pages/search/search_page.dart';

class TabManager extends StatefulWidget {
  @override
  _TabManagerState createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  TabItem _previousTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.recipes: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>()
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => HomePage(),
      TabItem.recipes: (_) => SavedRecipePage(),
      TabItem.search: (context) => SearchPage(),
      TabItem.account: (_) => AccountPage()
    };
  }

  void _selectTab(TabItem currentTab) {
    // This allows you to pop back to (the home) of the currently selected tab
    final currentTabState = navigatorKeys[currentTab]?.currentState;

    // Always pop to the first route when a tab is selected
    if (currentTabState != null) {
      navigatorKeys[currentTab]!.currentState!.popUntil(
            (route) => route.isFirst,
          );
    }

    // If the tab is the same as the previous tab, ensure any active route below the first route is popped
    if (currentTab == _previousTab) {
      navigatorKeys[currentTab]!.currentState!.maybePop();
    } else {
      setState(() => _previousTab = currentTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        navigatorKeys[_previousTab]!.currentState!.maybePop();
      },
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        currentTab: _previousTab,
        onSelectedTab: _selectTab,
        widgetBuilders: widgetBuilders,
      ),
    );
  }
}
