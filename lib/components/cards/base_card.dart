// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/chow.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double topMargin;

  BaseCard({
    required this.child,
    this.color = ChowColors.white,
    this.borderRadius = ChowBorderRadii.lg,
    this.topMargin = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: 4.0,
      color: color,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.all(
          Radius.circular(ChowBorderRadii.lg),
        ),
        child: child,
      ),
    );
  }
}
