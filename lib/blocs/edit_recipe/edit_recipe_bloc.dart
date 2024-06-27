import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRecipeBloc extends Bloc<EditRecipeEvent, EditRecipeState> {
  EditRecipeBloc(this._database) : super(EditRecipeInitial()) {
    on<EditRecipe>(_handleEditRecipe);
    on<RemoveIngredient>(_handleRemoveIngredient);
    on<AddIngredient>(_handleAddIngredient);
    on<RemoveInstruction>(_handleRemoveInstruction);
    on<AddInstruction>(_handleAddInstruction);
  }

  final FirestoreDatabase _database;

  void _handleEditRecipe(EditRecipeEvent event, Emitter<EditRecipeState> emit) {
    emit(EditRecipePending());
    emit(EditRecipeSuccess());
  }

  void _handleRemoveIngredient(
    RemoveIngredient event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipePending());
    emit(EditRecipeSuccess());
  }

  void _handleAddIngredient(
    AddIngredient event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipePending());
    emit(EditRecipeSuccess());
  }

  void _handleRemoveInstruction(
    RemoveInstruction event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipePending());
    emit(EditRecipeSuccess());
  }

  void _handleAddInstruction(
    AddInstruction event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipePending());
    emit(EditRecipeSuccess());
  }
}
