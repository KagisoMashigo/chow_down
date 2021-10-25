import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/cubit/search/search_cubit.dart';
import 'package:chow_down/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

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
  // BlocProvider<RecipeCubit>(
  //   create: (context) => RecipeCubit(
  //     RemoteRecipeRepository(),
  //   ),
  // ),
  BlocProvider<SearchCubit>(
    create: (context) => SearchCubit(
      RemoteSearchRepository(),
    ),
  ),
];
