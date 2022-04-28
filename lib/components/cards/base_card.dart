// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final double paddingHorizontal;
  final double paddingVertical;
  final double borderRadius;

  BaseCard({
    @required this.child,
    this.color = Colors.white,
    this.borderRadius = 16,
    this.paddingHorizontal = 16,
    this.paddingVertical = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.borderRadius),
      ),
      color: color,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal,
          vertical: paddingVertical,
        ),
        child: this.child,
      ),
    );
  }
}
