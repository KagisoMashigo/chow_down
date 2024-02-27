// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';

class ChowForm extends StatelessWidget {
  final void Function(BuildContext context, String url) submitForm;
  final TextEditingController _formUrl = TextEditingController();

  ChowForm({Key? key, required this.submitForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          child: TextField(
            controller: _formUrl,
            keyboardType: TextInputType.url,
            style: TextStyle(color: ChowColors.white),
            onSubmitted: (url) {
              submitForm(context, url);
              _formUrl.clear();
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: ChowColors.offWhite,
                fontSize: Spacing.sm,
              ),
              hintText: "Enter a recipe url here",
              focusColor: ChowColors.white,
              hintStyle: TextStyle(
                color: ChowColors.white,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: ChowColors.white,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ChowColors.white,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ChowColors.grey500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
