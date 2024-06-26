// 🐦 Flutter imports:
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/components/alert_dialogs/show_alert_dialog.dart';
import 'package:chow_down/components/avatar.dart';
import 'package:chow_down/components/chow_list_tile.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/services/auth.dart';

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

  Future<void> _deleteAllData(BuildContext context) async {
    try {
      BlocProvider.of<SavedRecipeBloc>(context)
          .add(DeleteEntireCollectionEvent());
    } catch (e) {}
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      isSave: false,
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _confirmCollectionDelete(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      isSave: false,
      title: 'Delete Collection',
      content:
          'Are you sure you want to delete your recipe collection? This is irreversible.',
      defaultActionText: 'I am born again',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _deleteAllData(context);
    }
  }

  Future<void> _confirmAccountDelete(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      isSave: false,
      title: 'Delete Account',
      content:
          'Are you sure you want to delete your account? This is irreversible.',
      defaultActionText: 'Chiao for now',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _deleteUser(context);
    }
  }

  Future<void> _confirmCacheDelete(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      isSave: false,
      title: 'Clear cache',
      content: 'Are you sure you? This is irreversible.',
      defaultActionText: 'Cache me outside',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _deleteCacheDir();
    }
  }

  Future<void> _confirmAppDataDelete(BuildContext context) async {
    final confirmSignOut = await showAlertDialog(
      context,
      isSave: false,
      title: 'Clear application data',
      content: 'Are you sure you? This is irreversible.',
      defaultActionText: 'App-reciated',
      cancelActionText: 'Cancel',
    );
    if (confirmSignOut == true) {
      _deleteAppDir();
    }
  }

  Widget _buildUserInfo(User user) {
    return Padding(
      padding: EdgeInsets.all(Spacing.sm),
      child: Row(
        children: [
          Avatar(
            radius: 8 * Responsive.ratioHorizontal,
            photoUrl: user.photoURL!,
          ),
          SizedBox(width: Spacing.sm),
          user.displayName != null
              ? Expanded(
                  child: Text(
                    user.displayName!,
                    style: TextStyle(
                        color: ChowColors.white,
                        fontSize: 5.5 * Responsive.ratioHorizontal),
                  ),
                )
              : Expanded(
                  child: Text(
                    '${user.email}',
                    style: TextStyle(
                        color: ChowColors.white,
                        fontSize: 4 * Responsive.ratioHorizontal),
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
            image: AssetImage(BACKGROUND_TEXTURE),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Spacing.sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Spacing.sm),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(Spacing.sm),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              color: ChowColors.white,
                              fontSize: ChowFontSizes.lg,
                            ),
                          ),
                        ),
                      ),
                      _buildUserInfo(auth.currentUser),
                      // TODO: add lang tile for intl & raw string constants
                      ChowListTile(
                        onTap: () async {
                          _confirmAccountDelete(context);
                        },
                        leading: Icon(
                          Icons.delete_forever,
                          color: ChowColors.white,
                        ),
                        title: Text(
                          'Delete account',
                          style: TextStyle(color: ChowColors.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_outlined,
                          color: ChowColors.white,
                        ),
                      ),
                      ChowListTile(
                        onTap: () async {
                          _confirmCollectionDelete(context);
                        },
                        leading: Icon(
                          Icons.clear,
                          color: ChowColors.white,
                        ),
                        title: Text(
                          'Clear recipes',
                          style: TextStyle(color: ChowColors.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_outlined,
                          color: ChowColors.white,
                        ),
                      ),
                      ChowListTile(
                        onTap: () async {
                          _confirmAppDataDelete(context);
                        },
                        leading: Icon(
                          Icons.delete_sweep,
                          color: ChowColors.white,
                        ),
                        title: Text(
                          'Delete application data',
                          style: TextStyle(color: ChowColors.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_outlined,
                          color: ChowColors.white,
                        ),
                      ),
                      ChowListTile(
                        onTap: () async {
                          _confirmCacheDelete(context);
                        },
                        leading: Icon(
                          Icons.cached,
                          color: ChowColors.white,
                        ),
                        title: Text(
                          'Clear cache',
                          style: TextStyle(color: ChowColors.white),
                        ),
                        trailing: Icon(
                          Icons.chevron_right_outlined,
                          color: ChowColors.white,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(Spacing.md),
                          padding: EdgeInsets.all(Spacing.sm),
                          backgroundColor: ChowColors.beige200,
                        ),
                        onPressed: () => _confirmSignOut(context),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: ChowFontSizes.sm,
                            color: ChowColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
