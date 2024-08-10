import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRecipeBloc extends Bloc<EditRecipeEvent, EditRecipeState> {
  EditRecipeBloc(this._database) : super(EditRecipeInitial()) {
    on<EditRecipe>(_handleEditRecipe);
    on<SaveEditedRecipe>(_handleSaveEditedRecipe);
    on<CancelEditRecipe>(_handleCancelEdit);
    on<RemoveIngredient>(_handleRemoveIngredient);
    on<AddIngredient>(_handleAddIngredient);
    on<RemoveInstruction>(_handleRemoveInstruction);
    on<AddInstruction>(_handleAddInstruction);
  }

  final FirestoreDatabase _database;

  void _handleEditRecipe(
    EditRecipe event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipePending(recipe: event.recipe));
  }

  void _handleSaveEditedRecipe(
    SaveEditedRecipe event,
    Emitter<EditRecipeState> emit,
  ) {
    // might need to change ID or doc id
    _database.saveEditedRecipe(event.recipe);

    _database.retrieveEditedRecipes();
    emit(EditRecipeSuccess(recipe: event.recipe));
  }

  void _handleCancelEdit(
    CancelEditRecipe event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipeFailure(message: 'Edit cancelled'));
  }

  void _handleRemoveIngredient(
    RemoveIngredient event,
    Emitter<EditRecipeState> emit,
  ) {
    // TODO: in this implementation we will need to deterime
    // the index of the ingredient to remove from the recipe
    // then copywith
    // emit(EditRecipeSuccess(recipe: ));
  }

  void _handleAddIngredient(
    AddIngredient event,
    Emitter<EditRecipeState> emit,
  ) {
    // TODO: in this implementation we will need to add
    // a new ingredient to the recipe in the ingredients list
    // then copywith
    // emit(EditRecipeSuccess(recipe: ));
  }

  void _handleRemoveInstruction(
    RemoveInstruction event,
    Emitter<EditRecipeState> emit,
  ) {
    // TODO: in this implementation we will need to deterime
    // the index of the instruction to remove from the recipe
    // then copywith
    // emit(EditRecipeSuccess(recipe: ));
  }

  void _handleAddInstruction(
    AddInstruction event,
    Emitter<EditRecipeState> emit,
  ) {
    // TODO: in this implementation we will need to add
    // a new instruction to the recipe in the instructions list
    // then copywith
    // emit(EditRecipeSuccess(recipe: ));
  }
}
