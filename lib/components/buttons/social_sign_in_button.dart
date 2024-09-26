// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';
import 'package:chow_down/components/design/typography.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required Widget pictureWidget,
    required String text,
    Color? color,
    Color? textColor,
    required VoidCallback onPressed,
  }) : super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pictureWidget,
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: ChowFontSizes.smd,
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: pictureWidget,
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
