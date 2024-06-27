abstract class EditRecipeEvent {
  const EditRecipeEvent();
}

class EditRecipe extends EditRecipeEvent {
  const EditRecipe();
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
