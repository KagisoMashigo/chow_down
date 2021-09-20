import 'package:chow_down/components/buttons/form_submit_button.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/models/page/email_sign_in_change_model.dart';
import 'package:chow_down/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

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

// TODO: this page really needs responsive designs
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  EmailSignInChangeModel get model => widget.model;
  String _alert;

  @override
  void initState() {
    super.initState();
    // alertTrue =t
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
        title: Text('Forgot Password'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 900,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/vege_home.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 120.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildEmailTextField(),
                        SizedBox(height: 8.0),
                        FormSubmitButton(
                          text: 'Reset Password',
                          onPressed: model.canReset ? _reset : null,
                        ),
                        _return()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.0),
                _showAlert(),
              ]),
        ),
      ),
      backgroundColor: Colors.grey[200],
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

  Widget _return() {
    return TextButton(
      child: Text('Return to Login'),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  /// Builds the header
  Widget _buildHeader() {
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        // TODO: Can make a better logo
        'assets/images/chow_down.png',
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _showAlert() {
    if (_alert != null) {
      return Container(
        color: Colors.greenAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _alert,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
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
    return SizedBox(
      height: 0,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      onChanged: model.updateEmail,
    );
  }
}
