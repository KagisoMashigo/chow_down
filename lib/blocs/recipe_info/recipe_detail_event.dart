// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeDetailEvent {
  const RecipeDetailEvent();
}

class FetchRecipe extends RecipeDetailEvent {
  final int id;
  final String url;
  final bool isEdited;
  final List<Recipe>? savedRecipes;

  const FetchRecipe({
    required this.id,
    required this.url,
    this.savedRecipes,
    this.isEdited = false,
  });

  @override
  String toString() => 'FetchRecipe{id: $id, url: $url, isEdited: $isEdited}';
}

class SaveRecipe extends RecipeDetailEvent {
  final Recipe recipe;

  const SaveRecipe({required this.recipe});
}

class FetchRecipeInformation extends RecipeDetailEvent {
  final int id;
  final String sourceUrl;

  const FetchRecipeInformation({required this.id, required this.sourceUrl});
}
