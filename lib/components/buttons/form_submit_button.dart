// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/custom_raised_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
    Color color,
  }) : super(
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
          height: 44.0,
          color: color,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
