// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeInfoEvent {
  const RecipeInfoEvent();
}

class FetchRecipe extends RecipeInfoEvent {
  final int id;
  final String url;
  final List<Recipe>? savedRecipes;

  const FetchRecipe({required this.id, required this.url, this.savedRecipes});
}

class SaveRecipe extends RecipeInfoEvent {
  final Recipe recipe;

  const SaveRecipe({required this.recipe});
}

class FetchRecipeInformation extends RecipeInfoEvent {
  final int id;
  final String sourceUrl;

  const FetchRecipeInformation({required this.id, required this.sourceUrl});
}
