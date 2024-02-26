import 'package:another_flushbar/flushbar.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:flutter/material.dart';

class FloatingFeedbackStyle {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Icon icon;

  const FloatingFeedbackStyle({
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
  });

  static const error = FloatingFeedbackStyle(
    textColor: ChowColors.grey900,
    backgroundColor: ChowColors.red100,
    borderColor: ChowColors.red700,
    icon: Icon(
      Icons.error,
      color: ChowColors.red700,
      size: 24,
    ),
  );

  static const success = FloatingFeedbackStyle(
    textColor: ChowColors.grey900,
    backgroundColor: ChowColors.green100,
    borderColor: ChowColors.green700,
    icon: Icon(
      Icons.check,
      color: ChowColors.green700,
      size: 24,
    ),
  );

  static const info = FloatingFeedbackStyle(
    textColor: ChowColors.white,
    backgroundColor: Colors.black,
    borderColor: Colors.black,
    icon: Icon(Icons.info, color: ChowColors.white),
  );

  static const alert = FloatingFeedbackStyle(
    textColor: Colors.black,
    backgroundColor: ChowColors.white,
    borderColor: ChowColors.grey200,
    icon: Icon(Icons.info, color: ChowColors.black),
  );
}

class FloatingFeedback {
  final Key? key;
  final String? title;
  final String message;
  final Duration? duration;
  final bool isDismissible;
  final FloatingFeedbackStyle style;
  final Function(Flushbar<dynamic>)? onTap;

  const FloatingFeedback({
    this.key,
    this.title,
    required this.message,
    this.duration,
    this.isDismissible = false,
    required this.style,
    this.onTap,
  });

  void show(BuildContext context) {
    Flushbar(
      key: key,
      titleText: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: style.textColor,
                fontWeight: ChowFontWeights.bold,
              ),
            )
          : null,
      messageText: Text(
        message,
        style: TextStyle(color: style.textColor),
      ),
      backgroundColor: style.backgroundColor,
      borderWidth: 1.0,
      borderColor: style.borderColor,
      borderRadius: BorderRadius.circular(4.0),
      isDismissible: isDismissible,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.25),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
      padding:
          EdgeInsets.symmetric(vertical: Spacing.sm, horizontal: Spacing.md),
      dismissDirection: FlushbarDismissDirection.VERTICAL,
      animationDuration: Duration(milliseconds: 500),
      margin: EdgeInsets.all(Spacing.sm),
      duration: duration,
      icon: style.icon,
      shouldIconPulse: false,
      onTap: onTap,
    )..show(context);
  }
}
