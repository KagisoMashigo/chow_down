// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';

// 🌎 Project imports:
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  String title,
  Exception exception,
}) =>
    showAlertDialog(
      context,
      isSave: false,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message;
  }
  return exception.toString();
}
