// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final Padding padding;
  final double borderRadius;
  final double paddingVertical;

  DetailCard({
    @required this.child,
    @required this.color,
    this.padding,
    this.borderRadius = 10,
    this.paddingVertical = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: paddingVertical,
      ),
      child: this.child,
    );
  }
}
