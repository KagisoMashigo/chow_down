// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_state.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class RecipeTabBloc extends Bloc<RecipeTabEvent, RecipeTabState> {
  final FirestoreDatabase _database;

  RecipeTabBloc(
    this._database,
  ) : super(RecipeTabInitial()) {
    on<FetchHomeRecipesEvent>(_handleFetchHomeRecipes);
    on<DeleteRecipeEvent>(_handleDeleteRecipe);
    on<DeleteEntireCollectionEvent>(_handleDeleteEntireCollection);
    on<Refresh>(_handleRefresh);

    add(FetchHomeRecipesEvent());
  }

  Future<void> _handleFetchHomeRecipes(
    FetchHomeRecipesEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      printDebug('Fetching home recipes...');
      emit(RecipeTabLoading(recipeCardList: []));

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();

      if (searchResults.isEmpty) {
        printDebug('No recipes found.');
        emit(RecipeTabInitial());
      } else {
        printDebug('Fetched ${searchResults.length} recipes.');
        emit(RecipeTabLoaded(recipeCardList: searchResults));
      }
    } on Failure catch (e, stack) {
      printAndLog(e, 'Fetching home recipes failed: $stack');
      emit(RecipeTabError(message: e.toString()));
    }
  }

  Future<void> _handleDeleteRecipe(
    DeleteRecipeEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      printDebug('Deleting recipe with ID: ${event.recipe.id}');
      emit(RecipeTabLoading(recipeCardList: []));

      await _database.deleteRecipe(event.recipe);
      printDebug('Recipe deleted with ID: ${event.recipe.id}');

      await Future<void>.delayed(const Duration(milliseconds: 50));

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (searchResults.isEmpty) {
        printDebug('No recipes found after deletion.');
        emit(RecipeTabInitial());
      } else {
        printDebug('Fetched ${searchResults.length} recipes after deletion.');
        emit(RecipeTabLoaded(recipeCardList: searchResults));
      }
    } on Failure catch (e, stack) {
      printAndLog(e, 'Deleting recipe failed: $stack');
      emit(RecipeTabError(message: e.toString()));
    }
  }

  Future<void> _handleDeleteEntireCollection(
    DeleteEntireCollectionEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      printDebug('Deleting entire collection of recipes.');
      emit(RecipeTabLoading(recipeCardList: []));

      await _database.deleteAllRecipes();
      printDebug('Entire collection deleted.');
    } on Failure catch (e, stack) {
      printAndLog(e, 'Deleting entire collection failed: $stack');
      emit(RecipeTabError(message: e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      printDebug('Refreshing recipe tab...');
      emit(RecipeTabLoading(recipeCardList: []));

      await Future<void>.delayed(const Duration(seconds: 2));

      printDebug('Recipe tab refresh complete.');
      emit(RecipeTabInitial());
    } on Failure catch (e, stack) {
      printAndLog(e, 'Refreshing recipe tab failed: $stack');
      emit(RecipeTabError(message: e.toString()));
    }
  }
}
