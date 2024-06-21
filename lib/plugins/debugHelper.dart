// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
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
      _printWithColour(message, '\x1B[30m');
      break;
    case DebugColour.red:
      _printWithColour(message, '\x1B[31m');
      break;
    case DebugColour.green:
      _printWithColour(message, '\x1B[32m');
      break;
    case DebugColour.yellow:
      _printWithColour(message, '\x1B[33m');
      break;
    case DebugColour.blue:
      _printWithColour(message, '\x1B[34m');
      break;
    case DebugColour.magenta:
      _printWithColour(message, '\x1B[35m');
      break;
    case DebugColour.cyan:
      _printWithColour(message, '\x1B[36m');
      break;
    case DebugColour.white:
      _printWithColour(message, '\x1B[37m');
      break;
    default:
      print(message);
      break;
  }
}

void _printWithColour(String message, String colourCode) {
  printDebug('$colourCode$message\x1B[0m');
}

void printAndLog(Object? object, String reason) {
  if (object is Exception) {
    _crashlytics.recordError(object, StackTrace.current, reason: reason);
  } else {
    _crashlytics.recordError(Exception(object), StackTrace.current,
        reason: reason);
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
