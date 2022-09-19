// 🐦 Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/social_sign_in_button.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/pages/sign_in/email_sign_in_page.dart';
import 'package:chow_down/pages/sign_in/sign_in_manager.dart';
import 'package:chow_down/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => SignInPage(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException && exception.code == "ERROR_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      exception: exception,
      title: 'Sign in Failed',
    );
  }

  // Future<void> _signInAnon(BuildContext context) async {
  //   try {
  //     await manager.signInAnonymously();
  //   } on Exception catch (e) {
  //     _showSignInError(context, e);
  //   }
  // }

  Future<void> _signInGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EmailSignInPage(),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _buildContent(context),
    );
  }

  /// Builds the header
  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        // TODO: Can make a better logo / reconsider padding or text size
        'assets/images/chow_down.png',
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Builds the body
  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Responsive.isSmallScreen()
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1502174832274-bc176e52765a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDJ8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(Responsive.ratioHorizontal * 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: Responsive.ratioVertical * 18.0),
              SocialSignInButton(
                pictureWidget: Image.asset('assets/images/google-logo.png'),
                text: 'Sign in with Google',
                textColor: Colors.black87,
                color: Colors.white,
                onPressed: () => isLoading ? null : _signInGoogle(context),
              ),
              SizedBox(height: Responsive.ratioHorizontal * 3.0),
              SocialSignInButton(
                pictureWidget: Image.asset('assets/images/facebook-logo.png'),
                text: 'Sign in with Facebook',
                textColor: Colors.white,
                color: Color(0xFF334D92),
                onPressed: () => isLoading ? null : _signInFacebook(context),
              ),
              SizedBox(height: Responsive.ratioHorizontal * 3.0),
              SocialSignInButton(
                pictureWidget: Icon(
                  Icons.email,
                  size: Responsive.ratioHorizontal * 9,
                  color: ChowColors.white,
                ),
                text: 'Sign in with email',
                textColor: Colors.white,
                color: Colors.green[900],
                onPressed: () => isLoading ? null : _signInEmail(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
