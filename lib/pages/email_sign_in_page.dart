import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chow_down/pages/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Sign In'),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/board_home.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: EmailSignInFormChangeNotifier.create(context),
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
