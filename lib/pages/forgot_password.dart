// 🐦 Flutter imports:
import 'package:chow_down/components/design/spacing.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Oopsie',
          style: TextStyle(fontSize: 7 * Responsive.ratioHorizontal),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 100 * Responsive.ratioVertical,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1556682851-c4580670113a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Spacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Spacing.sm),
              _showAlert(),
              SizedBox(height: Spacing.sm),
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(Responsive.ratioSquare * 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
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
            ],
          ),
        ),
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
        style: TextStyle(color: ChowColors.white),
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  // TODO: edit the actual email sent back
  Widget _showAlert() {
    return Container(
      width: 1 * Responsive.ratioHorizontal,
      padding: EdgeInsets.all(Spacing.sm),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Spacing.sm),
            child: Icon(Icons.error_outline),
          ),
          Expanded(
            child: AutoSizeText(
              _alert!,
              maxLines: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2 * Responsive.ratioHorizontal),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(
                  () {
                    _alert = null;
                  },
                );
              },
            ),
          )
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
        labelStyle: TextStyle(color: Colors.white, fontSize: 18),
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: model.updateEmail,
    );
  }
}
