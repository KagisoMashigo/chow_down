// 🐦 Flutter imports:
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/models/page/email_sign_in_change_model.dart';
import 'package:chow_down/services/auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => ForgotPasswordPage(model: model),
      ),
    );
  }

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  EmailSignInChangeModel get model => widget.model;
  String? _alert;

  @override
  void initState() {
    super.initState();
    _alert = '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  HOME_BACKGROUND_IMAGE,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                foregroundColor: ChowColors.white,
                title: Text(
                  'Whoops',
                  style: TextStyle(
                    fontSize: ChowFontSizes.xlg,
                    color: ChowColors.white,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: Column(
                children: [
                  _showAlert(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
                    child: Card(
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.all(Spacing.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildEmailTextField(),
                            SizedBox(height: Spacing.sm),
                            FormSubmitButton(
                              color: ChowColors.beige100,
                              text: 'Reset Password',
                              onPressed: model.canReset ? _reset : null,
                            ),
                            _returnToLogin()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _reset() async {
    try {
      await model.resetPassword();
      setState(() {
        _alert = 'An email has been sent to ${_emailController.text}';
      });
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Reset failed',
        exception: e,
      );
    }
  }

  Widget _returnToLogin() {
    return TextButton(
      child: Text(
        'Return to Login',
        style: TextStyle(
          color: ChowColors.white,
          fontSize: ChowFontSizes.sm,
        ),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _showAlert() {
    return Container(
      padding: EdgeInsets.all(Spacing.sm),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Spacing.sm),
          ),
          Expanded(
            child: AutoSizeText(
              _alert!,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      style: TextStyle(color: ChowColors.white),
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white, fontSize: ChowFontSizes.md),
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: model.updateEmail,
    );
  }
}
