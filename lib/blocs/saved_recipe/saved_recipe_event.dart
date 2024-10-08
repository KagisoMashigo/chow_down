// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class SavedRecipeEvent {
  const SavedRecipeEvent();
}

class FetchSavedRecipesEvent extends SavedRecipeEvent {
  const FetchSavedRecipesEvent();
}

class FetchEditedRecipesEvent extends SavedRecipeEvent {
  const FetchEditedRecipesEvent();
}

class DeleteRecipeEvent extends SavedRecipeEvent {
  final Recipe recipe;
  final bool isEdited;

  const DeleteRecipeEvent(this.recipe, {this.isEdited = false});
}

class DeleteEntireCollectionEvent extends SavedRecipeEvent {
  const DeleteEntireCollectionEvent();
}

class Refresh extends SavedRecipeEvent {
  const Refresh();
}
