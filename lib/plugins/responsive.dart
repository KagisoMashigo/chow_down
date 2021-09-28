// 🐦 Flutter imports:
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Responsive {
  static double _screenWidth;
  static double _screenHeight;
  static double _screenRatioHorizontal = 0;
  static double _screenRatioVertical = 0;

  static double ratioVertical;
  static double ratioHorizontal;
  static double ratioSquare;

  void init(BoxConstraints constraints, Orientation orientation) {
    final bool isPortraitOriented = orientation == Orientation.portrait;

    _screenWidth =
        isPortraitOriented ? constraints.maxWidth : constraints.maxHeight;
    _screenHeight =
        isPortraitOriented ? constraints.maxHeight : constraints.maxWidth;

    _screenRatioHorizontal = _screenWidth / 100;
    _screenRatioVertical = _screenHeight / 100;

    ratioVertical = _screenRatioVertical;
    ratioHorizontal = _screenRatioHorizontal;
    ratioSquare = _screenHeight / _screenWidth;
  }

  /// True IFF the horizontal ratio is less than 4 (Small screen)
  static bool isSmallScreen() => ratioHorizontal < 4;
}

SizedBox verticalDivider({double factor = 1.0}) =>
    SizedBox(height: factor * Responsive.ratioVertical);

SizedBox horizontalDivider({double factor = 1.0}) =>
    SizedBox(width: factor * Responsive.ratioHorizontal);
