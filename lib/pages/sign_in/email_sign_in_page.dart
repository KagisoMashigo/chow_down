import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/pages/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:time_tracker_flutter_course/pages/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:time_tracker_flutter_course/pages/sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifier.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
