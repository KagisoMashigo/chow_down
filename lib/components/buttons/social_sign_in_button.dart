// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';
import 'package:chow_down/components/design/responsive.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    @required Widget pictureWidget,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(pictureWidget != null),
        assert(text != null),
        super(
          child: Row(
            // The below is a great hack when spacing two children evenly
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pictureWidget,
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 4 * Responsive.ratioHorizontal,
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
