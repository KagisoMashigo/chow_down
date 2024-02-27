// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/cubit/home_page/extract_bloc.dart';
import 'package:chow_down/cubit/home_page/extract_event.dart';

class ChowForm extends StatelessWidget {
  ChowForm({Key? key}) : super(key: key);

  void _submitForm(BuildContext context, String url) =>
      context.read<ExtractBloc>().add(ExtractRecipe(url: url));

  final TextEditingController _formUrl = TextEditingController();

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
              _submitForm(context, url);
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
