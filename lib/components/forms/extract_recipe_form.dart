import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/cubit/home_page/extract_bloc.dart';
import 'package:chow_down/cubit/home_page/extract_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExtractRecipeForm extends StatelessWidget {
  const ExtractRecipeForm({Key? key}) : super(key: key);

  void _submitForm(BuildContext context, String url) =>
      context.read<ExtractBloc>().add(ExtractRecipe(url: url));

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _formUrl = TextEditingController();
    final validUrl = Uri.parse(_formUrl.text).isAbsolute;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _formUrl,
              keyboardType: TextInputType.url,
              style: TextStyle(color: ChowColors.white),
              textInputAction: TextInputAction.search,
              validator: (url) {
                if (url == null || url.isEmpty) {
                  FloatingFeedback(
                    message: 'URL is empty',
                    style: FloatingFeedbackStyle.alert,
                    duration: Duration(seconds: 2),
                  ).show(context);
                } else if (!validUrl) {
                  FloatingFeedback(
                    message: 'Please enter a valid URL',
                    style: FloatingFeedbackStyle.alert,
                    duration: Duration(seconds: 2),
                  ).show(context);

                  _formUrl.clear();
                }
                return null;
              },
              onFieldSubmitted: (url) {
                if (_formKey.currentState!.validate() && validUrl) {
                  _submitForm(context, url);
                }
              },
              decoration: InputDecoration(
                errorStyle: TextStyle(color: ChowColors.offWhite),
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
          ],
        ),
      ),
    );
  }
}
