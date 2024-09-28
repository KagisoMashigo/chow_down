// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key? key,
    required this.title,
    required this.message,
    this.icon,
  }) : super(key: key);

  final String title;
  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(message),
    ));
  }
}
