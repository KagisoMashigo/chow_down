// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class EditRecipeEvent {
  const EditRecipeEvent();
}

class EditRecipe extends EditRecipeEvent {
  final Recipe recipe;

  const EditRecipe({required this.recipe});
}

class SaveEditedRecipe extends EditRecipeEvent {
  final Recipe recipe;

  const SaveEditedRecipe({required this.recipe});
}

class CancelEditRecipe extends EditRecipeEvent {
  const CancelEditRecipe();
}
