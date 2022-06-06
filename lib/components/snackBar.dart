// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';

// 🌎 Project imports:

/// Creates a [Snackbar] with an error notification to be given to a [ScaffoldMessengerState.showSnackBar].
/// The text is the with the key for the [I18n.error] topic.
SnackBar errorNotification(
  String key, {
  String value,
  @required StackTrace stack,
}) {
  // TODO: i18n package
  // String errorMessage =
  // value == null ? i18n(I18n.error, key) : i18n(I18n.error, key, value);

  // if (errorMessage == null) {
  //   reportTranslationError('key $key is not existing', stack);
  //   errorMessage = i18n(I18n.error, 'default');
  // }

  // return warningSnackBar(errorMessage);
}

/// A [SnackBar] with a text that cannot be null, to be given to a [ScaffoldMessengerState.showSnackBar]
///
/// IFF dismissible is false, the snackBar cannot be dismissed by the user
SnackBar snackBarNotification(String text, {bool dismissible = true}) =>
    _snackbarNotification(
        Row(
          children: <Widget>[
            Flexible(child: Text(text)),
          ],
        ),
        dismissible: dismissible);

/// A [SnackBar] with an [Icons.warning_rounded] and a [text], that cannot be null, to be given to a
/// [ScaffoldMessengerState.showSnackBar]
///
/// IFF dismissible is false, the snackBar cannot be dismissed by the user
SnackBar successSnackBar(String text, {bool dismissible = true}) =>
    _snackbarNotification(
      _checkedTextRow(text),
      dismissible: dismissible,
    );

/// A [SnackBar] with an [Icons.warning_rounded] and a [text], that cannot be null, to be given to a
/// [ScaffoldMessengerState.showSnackBar]
///
/// IFF dismissible is false, the snackBar cannot be dismissed by the user
SnackBar warningSnackBar(String text, {bool dismissible = true}) =>
    _snackbarNotification(
      _warningTextRow(text),
      dismissible: dismissible,
    );

/// An [Icons.warning_rounded] with the [text] that cannot be null
Widget _warningTextRow(String text) => Row(
      children: <Widget>[
        Icon(Icons.warning_rounded),
        SizedBox(width: 4 * Responsive.ratioHorizontal),
        Flexible(child: Text(text)),
      ],
    );

/// An [Icons.check_circle] with the [text]. [text] cannot be null
Widget _checkedTextRow(String text) => Row(
      children: <Widget>[
        Icon(Icons.check_circle),
        SizedBox(width: 4 * Responsive.ratioHorizontal),
        Flexible(child: Text(text)),
      ],
    );

/// Show a Snackbar for 10 seconds.
/// Overrides [dismissable] to false to prevent the user to close the snackbar notification.
SnackBar _snackbarNotification(Widget child, {bool dismissible = true}) {
  return SnackBar(
    duration: Duration(seconds: 10),
    content: child,
    action: dismissible
        ? SnackBarAction(
            onPressed: () {},
            label: 'OK',
          )
        : null,
  );
}
