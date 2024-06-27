abstract class EditRecipeState {
  const EditRecipeState();
}

class EditRecipeInitial extends EditRecipeState {
  const EditRecipeInitial();
}

class EditRecipePending extends EditRecipeState {
  const EditRecipePending();
}

class EditRecipeSuccess extends EditRecipeState {
  const EditRecipeSuccess();
}

class EditRecipeFailure extends EditRecipeState {
  const EditRecipeFailure();
}
