// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:ansi_styles/ansi_styles.dart';
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum DebugColour {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
}

final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

void printDebug(Object? object, {Type? type, DebugColour? colour}) {
  if (kReleaseMode || object == null) {
    return;
  }

  final prefix = type != null ? '[$type] ' : '';
  final message = '$prefix${object.toString()}';

  switch (colour) {
    case DebugColour.black:
      print(AnsiStyles.black(message));
      break;
    case DebugColour.red:
      print(AnsiStyles.red(message));
      break;
    case DebugColour.green:
      print(AnsiStyles.green(message));
      break;
    case DebugColour.yellow:
      print(AnsiStyles.yellow(message));
      break;
    case DebugColour.blue:
      print(AnsiStyles.blue(message));
      break;
    case DebugColour.magenta:
      print(AnsiStyles.magenta(message));
      break;
    case DebugColour.cyan:
      print(AnsiStyles.cyan(message));
      break;
    case DebugColour.white:
      print(AnsiStyles.white(message));
      break;
    default:
      print(message);
      break;
  }
}

void printAndLog(Object? object, String reason) {
  if (object is Exception) {
    _crashlytics.recordError(object, StackTrace.current, reason: reason);
  } else {
    _crashlytics.recordError(
      Exception(object),
      StackTrace.current,
      reason: reason,
    );
  }
}

void prettyPrintJson(Object? object, {bool printInReleaseMode = false}) {
  try {
    final json = JsonEncoder.withIndent(' ').convert(object);
    for (var line in json.split('\n')) {
      if (printInReleaseMode || !kReleaseMode) {
        printDebug(line);
      }
    }
  } catch (e) {
    printDebug(e);
  }
}
