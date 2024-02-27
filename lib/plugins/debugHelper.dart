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
  if (kReleaseMode) {
    return;
  }
  if (object == null) {
    return;
  }

  switch (colour) {
    case DebugColour.black:
      printBlack((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.red:
      printRed((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.green:
      printGreen((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.yellow:
      printYellow((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.blue:
      printBlue((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.magenta:
      printMagenta((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.cyan:
      printCyan((type != null ? '[$type] ' : '') + object.toString());
      break;
    case DebugColour.white:
      printWhite((type != null ? '[$type] ' : '') + object.toString());
      break;
    default:
      print((type != null ? '[$type] ' : '') + object.toString());
      break;
  }
}

void printBlack(String value) {
  printDebug('\x1B[30m$value\x1B[0m');
}

void printRed(String value) {
  printDebug('\x1B[31m$value\x1B[0m');
}

void printGreen(String value) {
  printDebug('\x1B[32m$value\x1B[0m');
}

void printYellow(String value) {
  printDebug('\x1B[33m$value\x1B[0m');
}

void printBlue(String value) {
  printDebug('\x1B[34m$value\x1B[0m');
}

void printMagenta(String value) {
  printDebug('\x1B[35m$value\x1B[0m');
}

void printCyan(String value) {
  printDebug('\x1B[36m$value\x1B[0m');
}

void printWhite(String value) {
  printDebug('\x1B[37m$value\x1B[0m');
}

void printAndLog(Object? object, String reason) {
  if (object is Exception) {
    _crashlytics.recordError(
      object,
      StackTrace.current,
      reason: reason,
    );
  } else {
    _crashlytics.recordError(
      Exception(object),
      StackTrace.current,
      reason: reason,
    );
  }
}

/// Converts objects to JSON and pretty prints, if [object] is already JSON, it will
/// be encoded on multiple lines with a space indent rather than a single line.
///
/// When [printInReleaseMode] is true, the JSON will be pretty printed in
/// release builds.
void prettyPrintJson(Object? object, {bool printInReleaseMode = false}) {
  try {
    final json = JsonEncoder.withIndent(' ').convert(object);
    json.split('\n').forEach(
          (line) => printInReleaseMode ? print(line) : printDebug(line),
        );
  } catch (e) {
    printDebug(e);
  }
}
