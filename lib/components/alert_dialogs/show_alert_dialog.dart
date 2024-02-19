// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(
  BuildContext context, {
  required bool isSave,
  required String title,
  required String content,
  required String defaultActionText,
  String? cancelActionText,
}) {
  // TODO: sign in is too abrupt, need to add a transition
  if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: isSave ? null : Text(content),
            actions: isSave
                ? null
                : <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelActionText!),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(defaultActionText),
                    ),
                  ],
          );
        });
  }
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        // Need to clear form on failure
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              // huh?? need to investigate
              child: Text(cancelActionText!),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText),
            ),
          ],
        );
      });
}
