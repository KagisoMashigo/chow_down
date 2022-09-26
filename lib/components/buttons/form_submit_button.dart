// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
    Color color,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: ChowColors.white,
              fontSize: 5.25 * Responsive.ratioHorizontal,
            ),
          ),
          height: 6 * Responsive.ratioVertical,
          color: color,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
