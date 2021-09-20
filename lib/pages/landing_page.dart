import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chow_down/pages/home/tab_manager.dart';
import 'package:chow_down/pages/sign_in/sign_in_page.dart';
import 'package:chow_down/services/auth.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          return Provider<Database>(
            create: (_) => FirestoreDatabase(uid: user.uid),
            child: TabManager(),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
