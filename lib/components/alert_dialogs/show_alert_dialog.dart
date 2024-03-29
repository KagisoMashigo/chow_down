// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  @required bool isSave,
  @required String title,
  @required String content,
  @required String defaultActionText,
  String cancelActionText,
}) {
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
                    if (cancelActionText != null)
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(cancelActionText),
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
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancelActionText),
              ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText),
            ),
          ],
        );
      });
}
