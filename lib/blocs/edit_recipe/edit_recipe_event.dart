import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class EditRecipeEvent {
  const EditRecipeEvent();
}

class EditRecipe extends EditRecipeEvent {
  final Recipe recipe;

  const EditRecipe({required this.recipe});
}

class RemoveIngredient extends EditRecipeEvent {
  final int index;

  const RemoveIngredient({required this.index});
}

class AddIngredient extends EditRecipeEvent {
  const AddIngredient();
}

class RemoveInstruction extends EditRecipeEvent {
  final int index;

  const RemoveInstruction({required this.index});
}

class AddInstruction extends EditRecipeEvent {
  const AddInstruction();
}
