// 🎯 Dart imports:
import 'dart:math';

// 🐦 Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/avatar.dart';
import 'package:chow_down/components/chow_list_tile.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/services/auth.dart';

const FLAVOURS = [
  'Chocolate Chip',
  'Hazelnut',
  'Vanilla Swirl',
  'Pistachio',
  'Salted Caramel Crunch',
  'Rum & Raisin',
  'Chocolate Vanilla Swirl'
];

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } catch (e) {}
  }

  Future<void> _deleteUser(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.deleteUser();
      await auth.signOut();
    } catch (e) {}
  }

  // TODO: better name generator
  Future<String> _anonGenerator(List names) {}

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

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content:
          'Are you sure you want to delete your account? This is irreversible.',
      defaultActionText: 'Chiao For Now',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _deleteUser(context);
    }
  }

  Widget _buildUserInfo(User user) {
    return Padding(
      padding: EdgeInsets.all(15 * Responsive.ratioSquare),
      child: Row(
        children: [
          Avatar(
            radius: 15 * Responsive.ratioHorizontal,
            photoUrl: user.photoURL,
          ),
          horizontalDivider(factor: 5),
          user.displayName != null
              ? Expanded(
                  child: Text(
                    user.displayName,
                    style: TextStyle(
                        color: ChowColors.white,
                        fontSize: 5.5 * Responsive.ratioHorizontal),
                  ),
                )
              : Expanded(
                  child: Text(
                    'Anonymous ${FLAVOURS.elementAt(
                      Random().nextInt(FLAVOURS.length),
                    )}',
                    style: TextStyle(
                        color: ChowColors.white,
                        fontSize: 5.5 * Responsive.ratioHorizontal),
                  ),
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1614014077943-840960ce6694?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDl8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: defaultPadding(),
          child: Padding(
            padding: defaultPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUserInfo(auth.currentUser),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: defaultPadding(),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          color: ChowColors.white,
                          fontSize: 5.25 * Responsive.ratioHorizontal),
                    ),
                  ),
                ),
                // TODO: add lang tile for intl & raw string constants
                ChowListTile(
                  onTap: () async {
                    _confirmDelete(context);
                  },
                  leading: Icon(
                    Icons.data_exploration_outlined,
                    color: ChowColors.white,
                  ),
                  title: Text(
                    'Delete Account',
                    style: TextStyle(color: ChowColors.white),
                  ),
                  trailing: Icon(
                    Icons.chevron_right_outlined,
                    color: ChowColors.white,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size.fromHeight(10 * Responsive.ratioHorizontal),
                    padding: defaultPadding(),
                    primary: ChowColors.beige200,
                  ),
                  onPressed: () => _confirmSignOut(context),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 4.25 * Responsive.ratioHorizontal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
