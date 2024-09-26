// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/models/page/email_sign_in_change_model.dart';
import 'package:chow_down/pages/forgot_password.dart';
import 'package:chow_down/services/auth.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  EmailSignInFormChangeNotifier({required this.model});
  final EmailSignInChangeModel model;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        builder: (_, model, __) => EmailSignInFormChangeNotifier(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      SizedBox(height: Spacing.sm),
      _buildPasswordTextField(),
      SizedBox(height: Spacing.sm),
      FormSubmitButton(
        color: ChowColors.beige100,
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: Spacing.sm),
      TextButton(
        child: Text(
          model.secondaryButtonText,
          style: TextStyle(
            color: ChowColors.white,
            fontSize: ChowFontSizes.sm,
          ),
        ),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
      model.passwordForgotten
          ? _showForgotPasswordButton(model.passwordForgotten)
          : Container()
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      style: TextStyle(color: ChowColors.white, fontSize: 18),
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: ChowColors.white),
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: model.updatePassword,
      onEditingComplete: _submit,
    );
  }

  Visibility _showForgotPasswordButton(bool visible) {
    return Visibility(
      child: TextButton(
          child: Text(
            'Forgot your password?',
            style: TextStyle(
              color: ChowColors.white,
              fontSize: ChowFontSizes.sm,
            ),
          ),
          onPressed: () => _forgotPassword(context)),
      visible: visible,
    );
  }

  void _forgotPassword(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ForgotPasswordPage.create(context),
      fullscreenDialog: true,
    ));
  }

  TextField _buildEmailTextField() {
    return TextField(
      style: TextStyle(color: ChowColors.white, fontSize: 18),
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: ChowColors.white),
        labelText: 'Email',
        hintStyle: TextStyle(color: ChowColors.grey500),
        hintText: 'chow@down.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Spacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
