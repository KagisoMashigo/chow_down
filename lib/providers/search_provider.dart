import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/domain/models/search/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/providers/authenticated_provider.dart';
import 'package:chow_down/providers/busy_provider.dart';
import 'package:chow_down/services/recipe_service.dart';
import 'package:chow_down/services/search_service.dart';

class SearchProvider extends BusyProvider implements AuthenticatedProvider {
  SearchProvider({RecipeService service})
      : _service = service ?? SearchService.instance;

  SearchService _service;

  List<SearchResultList> _recipes;

  /// Copy of the list of sources of this group
  List<SearchResultList> get results => _recipes;

  Future<void> getRecipeResults() async {
    try {
      final response = await _service.getRecipe();
      print('Res: $response');
      _recipes = response ?? <Recipe>[];
      print('Recipes: $_recipes');
    } catch (e) {
      if (e is ApiException) {
        print(e);
      }
      print(e);
    }
  }

  @override
  void init() {
    _service = _service ?? RecipeService.instance;
  }

  void logout() {
    _service = null;
    _recipes = <SearchResultList>[];
  }
}
