// 🐦 Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/pages/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 6.5 * Responsive.ratioHorizontal,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1623595119708-26b1f7300075?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2566&q=80',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            verticalDivider(factor: 15),
            Padding(
              padding: EdgeInsets.all(Responsive.ratioSquare * 9),
              child: Card(
                color: Colors.transparent,
                child: EmailSignInFormChangeNotifier.create(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
