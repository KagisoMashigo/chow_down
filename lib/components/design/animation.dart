// 🎯 Dart imports:
import 'dart:ui';

// 🌎 Project imports:
import 'package:chow_down/components/design/color.dart';

class ChowAnimationTokens {
  static const Duration navTransitionDuration = Duration(milliseconds: 250);
  static const Duration durationShort = Duration(milliseconds: 250);
  static const Duration durationMedium = Duration(seconds: 8);
  static const Duration durationLong = Duration(seconds: 12);
}

class ChowShimmerToken {
  static const Duration duration = Duration(milliseconds: 500);
  static const Color highlightColor = ChowColors.grey200;
  static const Color chowColor = ChowColors.grey400;
}

/// Durations of the "fake" loading: when an action should look
/// asynchronous to the user.
class ChowLoadingToken {
  static const Duration durationShort = Duration(milliseconds: 500);
  static const Duration durationLong = Duration(seconds: 2);
  static const Duration durationTimeout = Duration(seconds: 15);
}
