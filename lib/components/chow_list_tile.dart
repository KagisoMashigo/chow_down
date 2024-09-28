// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ChowListTile extends StatelessWidget {
  const ChowListTile({
    Key? key,
    required this.title,
    required this.onTap,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final Text title;
  final Icon? leading;
  final Icon? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ?? Icon(Icons.data_exploration_outlined),
      title: title,
      onTap: onTap,
      trailing: trailing ?? Icon(Icons.chevron_right_outlined),
    );
  }
}
