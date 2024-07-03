// 🐦 Flutter imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 📦 Package imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/home_page/extract_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_bloc.dart';
import 'package:chow_down/blocs/search/search_bloc.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/typography.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/pages/landing_page.dart';
import 'package:chow_down/services/auth.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final database = FirestoreDatabase(uid: Auth().currentUser.uid);

    Widget widget = MultiBlocProvider(
      providers: [
        Provider<AuthBase>(
          create: (_) => Auth(),
        ),
        BlocProvider<RecipeInfoBloc>(
          create: (context) => RecipeInfoBloc(
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              Responsive.init(constraints, orientation);
              SystemChrome.setPreferredOrientations(
                [
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
              );
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white,
                  systemNavigationBarIconBrightness: Brightness.dark,
                ),
              );
              return ChowDown();
            },
          );
        },
      ),
    );

    return widget;
  }
}

class ChowDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: ChowColors.black,
      title: 'Chow Down',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        fontFamily: ChowFontFamilies.primary,
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
      home: LandingPage(),
    );
  }
}
