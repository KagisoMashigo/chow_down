// 🐦 Flutter imports:
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/buttons/social_sign_in_button.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/pages/sign_in/email_sign_in_page.dart';
import 'package:chow_down/pages/sign_in/sign_in_manager.dart';
import 'package:chow_down/services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);
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

  Future<void> _signInGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  SIGN_IN_PAGE_BACKGROUND_IMAGE,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: _buildContent(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double imageSize = 150;
        if (constraints.maxWidth < 150) {
          imageSize = constraints.maxWidth;
        }
        return Container(
          alignment: Alignment.center,
          child: Image.asset(
            CHOW_DOWN_LOGO,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: Spacing.xlg),
            SocialSignInButton(
              pictureWidget: Image.asset('assets/images/google-logo.png'),
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: () => isLoading ? null : _signInGoogle(context),
            ),
            SizedBox(height: Spacing.md),
            SocialSignInButton(
              pictureWidget: Icon(
                Icons.email,
                size: Spacing.md,
                color: ChowColors.white,
              ),
              text: 'Sign in with email',
              textColor: Colors.white,
              color: Colors.green[900]!,
              onPressed: () => isLoading ? null : _signInEmail(context),
            ),
          ],
        ),
      ),
    );
  }
}
