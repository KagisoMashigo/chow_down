// 🐦 Flutter imports:
import 'package:flutter/material.dart';

enum TabItem { home, recipes, search, account }

class TabItemData {
  const TabItemData({@required this.label, @required this.icon});

  final String label;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.home: TabItemData(label: 'Home', icon: Icons.home),
    TabItem.recipes: TabItemData(label: 'Recipes', icon: Icons.food_bank),
    TabItem.search: TabItemData(label: 'Search', icon: Icons.search),
    TabItem.account: TabItemData(label: 'Account', icon: Icons.person),
  };
}
