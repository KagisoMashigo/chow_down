// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:chow_down/blocs/home_page/extract_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/search/search_bloc.dart';
import 'package:chow_down/components/bottom_nav/tab_manager.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/pages/sign_in/sign_in_page.dart';
import 'package:chow_down/services/auth.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPage.create(context);
          }
          final database = FirestoreDatabase(uid: user.uid);

          return MultiBlocProvider(
            providers: [
              BlocProvider<RecipeDetailBloc>(
                create: (context) => RecipeDetailBloc(
                  RemoteRecipe(),
                  database,
                ),
              ),
              BlocProvider<SavedRecipeBloc>(
                create: (context) => SavedRecipeBloc(
                  database,
                ),
              ),
              BlocProvider<SearchBloc>(
                create: (context) => SearchBloc(
                  RemoteSearchRepository(),
                ),
              ),
              BlocProvider<ExtractBloc>(
                create: (context) => ExtractBloc(
                  RemoteRecipe(),
                ),
              ),
              BlocProvider<EditRecipeBloc>(
                create: (context) => EditRecipeBloc(
                  database,
                ),
              ),
            ],
            child: Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: TabManager(),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: ChowColors.white,
            ),
          ),
        );
      },
    );
  }
}
