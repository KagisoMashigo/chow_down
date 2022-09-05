// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/cubit/home_page/extract_cubit.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';
import 'package:chow_down/cubit/search/search_cubit.dart';
import 'package:chow_down/services/auth.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

/// all providers being used in the application
final providers = <SingleChildWidget>[
  ..._authProviders,
  ..._functionalityProviders,
];

/// All providers being used through user management, sign in and sign out
final _authProviders = <SingleChildWidget>[
  Provider<AuthBase>(
    create: (_) => Auth(),
  ),
];

/// Providers that may or may not require an token, but provides functionality on the scope
/// of the app domains
final _functionalityProviders = <SingleChildWidget>[
  BlocProvider<RecipeInfoCubit>(
    create: (context) => RecipeInfoCubit(
      RemoteRecipe(),
      FirestoreDatabase(uid: Auth().currentUser.uid),
    ),
  ),
  BlocProvider<RecipeTabCubit>(
    create: (context) => RecipeTabCubit(
      FirestoreDatabase(uid: Auth().currentUser.uid),
    ),
  ),
  BlocProvider<SearchCubit>(
    create: (context) => SearchCubit(
      RemoteSearchRepository(),
    ),
  ),
  BlocProvider<ExtractCubit>(
    create: (context) => ExtractCubit(
      RemoteSearchRepository(),
    ),
  ),
];
