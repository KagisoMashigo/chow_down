// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:auto_size_text/auto_size_text.dart';
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
  ForgotPasswordPage({@required this.model});
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
  String _alert;

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
            image: NetworkImage(
                'https://images.unsplash.com/photo-1556682851-c4580670113a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDEyfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: defaultPadding(),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalDivider(factor: 15),
                _showAlert(),
                verticalDivider(),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(6 * Responsive.ratioSquare),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildEmailTextField(),
                        verticalDivider(),
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
              ]),
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
    if (_alert != null) {
      return Container(
        width: 1 * Responsive.ratioHorizontal,
        padding: defaultPadding(),
        child: Row(
          children: <Widget>[
            Padding(
              padding: defaultPadding(),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _alert,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2 * Responsive.ratioHorizontal),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _alert = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return verticalDivider(
      factor: 0,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: model.updateEmail,
    );
  }
}
