// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/saved_recipe/saved_recipe_event.dart';
import 'package:chow_down/blocs/saved_recipe/saved_recipe_state.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class SavedRecipeBloc extends Bloc<SavedRecipeEvent, SavedRecipeState> {
  final FirestoreDatabase _database;

  SavedRecipeBloc(
    this._database,
  ) : super(SavedRecipeInitial()) {
    on<FetchSavedRecipesEvent>(_handleFetchSavedRecipes);
    on<DeleteRecipeEvent>(_handleDeleteRecipe);
    on<DeleteEntireCollectionEvent>(_handleDeleteEntireCollection);
    on<Refresh>(_handleRefresh);

    add(FetchSavedRecipesEvent());
  }

  Future<void> _handleFetchSavedRecipes(
    FetchSavedRecipesEvent event,
    Emitter<SavedRecipeState> emit,
  ) async {
    try {
      printDebug('Fetching home recipes...');
      emit(SavedRecipePending(recipeCardList: [], editedRecipeList: []));

      final List<Recipe> savedRecipes = await _database.retrieveSavedRecipes();
      final List<Recipe> editedRecipes =
          await _database.retrieveEditedRecipes();

      if (savedRecipes.isEmpty) {
        printDebug('No recipes found.');
        emit(SavedRecipeInitial());
      } else {
        printDebug('Fetched ${savedRecipes.length} recipes.');
        emit(SavedRecipeLoaded(
            savedRecipeList: savedRecipes, editedRecipeList: editedRecipes));
      }
    } on Failure catch (e, stack) {
      printAndLog(e, 'Fetching home recipes failed: $stack');
      emit(SavedRecipeError(message: e.toString()));
    }
  }

  // Future<void> _handleFetchEditedRecipes(
  //   FetchEditedRecipesEvent event,
  //   Emitter<SavedRecipeState> emit,
  // ) async {
  //   try {
  //     printDebug('Fetching edited recipes...');
  //     emit(SavedRecipePending(editedRecipeList: []));

  //     final List<Recipe> editedRecipes =
  //         await _database.retrieveEditedRecipes();

  //     if (editedRecipes.isEmpty) {
  //       printDebug('No recipes found.');
  //       emit(SavedRecipeInitial());
  //     } else {
  //       printDebug('Fetched ${editedRecipes.length} recipes.');
  //       emit(SavedRecipeLoaded(editedRecipeList: editedRecipes));
  //     }
  //   } on Failure catch (e, stack) {
  //     printAndLog(e, 'Fetching edited recipes failed: $stack');
  //     emit(SavedRecipeError(message: e.toString()));
  //   }
  // }

  Future<void> _handleDeleteRecipe(
    DeleteRecipeEvent event,
    Emitter<SavedRecipeState> emit,
  ) async {
    try {
      printDebug('Deleting recipe with ID: ${event.recipe.id}');
      emit(SavedRecipePending());

      await _database.deleteRecipe(event.recipe, isEdited: event.isEdited);
      printDebug('Recipe deleted with ID: ${event.recipe.id}');

      await Future<void>.delayed(const Duration(milliseconds: 50));

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (searchResults.isEmpty) {
        printDebug('No recipes found after deletion.');
        emit(SavedRecipeInitial());
      } else {
        printDebug('Fetched ${searchResults.length} recipes after deletion.');
        emit(SavedRecipeLoaded(savedRecipeList: searchResults));
      }
    } on Failure catch (e, stack) {
      printAndLog(e, 'Deleting recipe failed: $stack');
      emit(SavedRecipeError(message: e.toString()));
    }
  }

  Future<void> _handleDeleteEntireCollection(
    DeleteEntireCollectionEvent event,
    Emitter<SavedRecipeState> emit,
  ) async {
    try {
      printDebug('Deleting entire collection of recipes.');
      emit(SavedRecipePending(recipeCardList: []));

      await _database.deleteAllRecipes();
      printDebug('Entire collection deleted.');
    } on Failure catch (e, stack) {
      printAndLog(e, 'Deleting entire collection failed: $stack');
      emit(SavedRecipeError(message: e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<SavedRecipeState> emit,
  ) async {
    try {
      printDebug('Refreshing recipe tab...');
      emit(SavedRecipePending(recipeCardList: []));

      await Future<void>.delayed(const Duration(seconds: 2));

      printDebug('Recipe tab refresh complete.');
      emit(SavedRecipeInitial());
    } on Failure catch (e, stack) {
      printAndLog(e, 'Refreshing recipe tab failed: $stack');
      emit(SavedRecipeError(message: e.toString()));
    }
  }
}
