import 'package:chow_down/providers/recipe_provider.dart';
import 'package:chow_down/providers/search_provider.dart';
import 'package:chow_down/services/auth.dart';
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
  ChangeNotifierProvider<RecipeProvider>(
    create: (_) => RecipeProvider(),
  ),
  ChangeNotifierProvider<SearchProvider>(
    create: (_) => SearchProvider(),
  ),
];
