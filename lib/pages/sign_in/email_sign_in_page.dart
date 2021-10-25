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
        title: Text(
          'Sign In',
          style: TextStyle(fontSize: 25),
        ),
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1488900128323-21503983a07e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDh8fGZvb2R8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              // TODO: play around with transparency
              // color: Colors.transparent,
              child: EmailSignInFormChangeNotifier.create(context),
            ),
          ),
        ]),
      ),
      // backgroundColor: Colors.grey[200],
    );
  }
}
