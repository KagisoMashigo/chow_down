import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chow_down/components/buttons/custom_raised_button.dart';

class FormSubmitButton extends CustomElevatedButton {
  FormSubmitButton({
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
          height: 44.0,
          color: Colors.indigo,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
