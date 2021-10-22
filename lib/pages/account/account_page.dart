import 'package:chow_down/plugins/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/avatar.dart';
import 'package:chow_down/services/auth.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _signOut(context);
    }
  }

  Widget _buildUserInfo(User user) {
    return Center(
      child: Column(
        children: [
          verticalDivider(factor: 5),
          Avatar(
            radius: 50,
            photoUrl: user.photoURL,
          ),
          verticalDivider(factor: 2),
          if (user.displayName != null)
            Text(
              user.displayName,
              style: TextStyle(color: Colors.white),
            ),
          verticalDivider(factor: 9),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Text('Account'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1609770231080-e321deccc34c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1365&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(auth.currentUser),
              Text(
                'Placeholder: options',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 2 * Responsive.ratioVertical),
              ),
              verticalDivider(factor: 4),
              Text(
                'Placeholder: more options? Lol',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 2 * Responsive.ratioVertical),
              ),
              verticalDivider(factor: 4),
              Text(
                'Placeholder: make these tiles',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 2 * Responsive.ratioVertical),
              ),
              verticalDivider(factor: 4),
              Text(
                'Placeholder: make logout more prominent',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 2 * Responsive.ratioVertical),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
