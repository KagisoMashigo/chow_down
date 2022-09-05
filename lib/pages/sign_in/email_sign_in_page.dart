// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/pages/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            image: NetworkImage(
                'https://images.unsplash.com/photo-1562790879-dfde82829db0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDExfHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          verticalDivider(factor: 13),
          Padding(
            padding: defaultPadding(),
            child: Card(
              color: Colors.transparent,
              child: EmailSignInFormChangeNotifier.create(context),
            ),
          ),
        ]),
      ),
    );
  }
}
