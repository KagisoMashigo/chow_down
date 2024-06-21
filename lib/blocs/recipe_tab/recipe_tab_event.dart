// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class RecipeTabEvent {
  const RecipeTabEvent();
}

class FetchHomeRecipesEvent extends RecipeTabEvent {
  const FetchHomeRecipesEvent();
}

class DeleteRecipeEvent extends RecipeTabEvent {
  final Recipe recipe;

  const DeleteRecipeEvent(this.recipe);
}

class DeleteEntireCollectionEvent extends RecipeTabEvent {
  const DeleteEntireCollectionEvent();
}

class Refresh extends RecipeTabEvent {
  const Refresh();
}
