// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/color.dart';

class ChowBaseText extends StatelessWidget {
  final Widget child;
  final String text;
  final double fontSize;

  ChowBaseText({
    @required this.child,
    @required this.text,
    this.fontSize = 4,
  });

  /// Always use in a col, row or flex
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class ChowFontFamilies {
  static const String primary = 'Lato';
  static const String secondary = 'Helvetica Neue';
}

class ChowFontColors {
  static const Color base = ChowColors.grey900;
  static const Color muted = ChowColors.grey600;
  static const Color link = ChowColors.blue600;
  static const Color invertedBase = ChowColors.white;
}

class ChowFontWeights {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;
}

class ChowLineHeights {
  static const double _base = 1.5;

  static const double xsm = 1.0;
  static const double sm = 1.25;
  static const double md = _base;
  static const double lg = 1.75;
  static const double xlg = 2.0;
}
