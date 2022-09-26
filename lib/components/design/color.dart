// 🎯 Dart imports:
import 'dart:ui';

class ChowColors {
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0);

  static const Color blue = Color.fromRGBO(0, 93, 170, 1);
  static const Color red = Color.fromRGBO(227, 24, 55, 1);
  static const Color offWhite = Color.fromRGBO(255, 255, 255, 1);
  //blue
  static const Color blue100 = Color.fromRGBO(229, 241, 246, 1);
  static const Color blue300 = Color.fromARGB(255, 28, 202, 255);
  static const Color blue600 = Color.fromRGBO(48, 113, 169, 1);
  static const Color blue700 = Color.fromRGBO(0, 93, 170, 1);

  //white
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  //grey
  static const Color grey100 = Color.fromRGBO(245, 245, 245, 1);
  static const Color grey200 = Color.fromRGBO(234, 234, 234, 1);
  static const Color grey300 = Color.fromRGBO(215, 215, 215, 1);
  static const Color grey400 = Color.fromRGBO(204, 204, 204, 1);
  static const Color grey500 = Color.fromRGBO(156, 156, 156, 1);
  static const Color grey600 = Color.fromRGBO(115, 115, 115, 1);
  static const Color grey700 = Color.fromRGBO(95, 95, 95, 1);
  static const Color grey900 = Color.fromRGBO(51, 51, 51, 1);
  //green
  static const Color green100 = Color.fromRGBO(224, 237, 224, 1);
  static const Color green700 = Color.fromRGBO(1, 128, 0, 1);
  //red
  static const Color red100 = Color.fromRGBO(253, 214, 214, 1);
  static const Color red700 = Color.fromRGBO(211, 32, 41, 1);
  //beige
  static const Color beige100 = Color.fromARGB(255, 200, 196, 181);
  static const Color beige200 = Color.fromRGBO(166, 163, 149, 1);

  static Color getColorWithGivenOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.green, color.green, color.blue, opacity);
  }
}
