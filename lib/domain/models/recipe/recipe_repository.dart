import 'package:chow_down/domain/models/recipe/recipe_model.dart';

abstract class RecipeRepository {
  Future<Recipe> getRecipe();
}
