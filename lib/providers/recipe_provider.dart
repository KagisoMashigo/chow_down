import 'package:chow_down/domain/models/recipe/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/providers/authenticated_provider.dart';
import 'package:chow_down/providers/busy_provider.dart';
import 'package:chow_down/services/recipe_service.dart';

class RecipeProvider extends BusyProvider implements AuthenticatedProvider {
  RecipeProvider({RecipeService service})
      : _service = service ?? RecipeService.instance;

  RecipeService _service;

  List<Recipe> _recipes;

  /// Copy of the list of sources of this group
  List<Recipe> get recipes => _recipes;

  Future<void> getRecipeHome() async {
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
    _recipes = <Recipe>[];
  }
}
