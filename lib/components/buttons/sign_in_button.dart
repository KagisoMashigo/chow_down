// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';
import 'package:chow_down/components/design/chow.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    required String text,
    Color? color,
    Color? textColor,
    required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: ChowFontSizes.md,
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
