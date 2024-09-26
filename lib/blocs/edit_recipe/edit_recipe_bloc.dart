// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/edit_recipe/edit_recipe_event.dart';
import 'package:chow_down/blocs/edit_recipe/edit_recipe_state.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class EditRecipeBloc extends Bloc<EditRecipeEvent, EditRecipeState> {
  EditRecipeBloc(this._database) : super(EditRecipeInitial()) {
    on<EditRecipe>(_handleEditRecipe);
    on<SaveEditedRecipe>(_handleSaveEditedRecipe);
    on<CancelEditRecipe>(_handleCancelEdit);
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
    _database.saveRecipe(event.recipe);

    _database.retrieveSavedRecipes();
    emit(EditRecipeSuccess(recipe: event.recipe));
  }

  void _handleCancelEdit(
    CancelEditRecipe event,
    Emitter<EditRecipeState> emit,
  ) {
    emit(EditRecipeFailure(message: 'Edit cancelled'));
  }
}
