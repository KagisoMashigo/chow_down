// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/design/typography.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    required String text,
    final VoidCallback? onPressed,
    final Color? color,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: ChowColors.white,
              fontSize: ChowFontSizes.md,
            ),
          ),
          height: Spacing.lg,
          color: color!,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
