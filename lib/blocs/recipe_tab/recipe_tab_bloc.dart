// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_state.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
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
  }

  Future<void> _handleFetchHomeRecipes(
    FetchHomeRecipesEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      emit(RecipeTabLoading());

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();

      if (searchResults.isEmpty) {
        emit(RecipeTabInitial());
      } else {
        emit(RecipeTabLoaded(recipeCardList: searchResults));
      }
    } on Failure catch (e) {
      emit(RecipTabError(message: e.toString()));
    }
  }

  Future<void> _handleDeleteRecipe(
    DeleteRecipeEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      emit(RecipeTabLoading());

      await _database.deleteRecipe(event.recipe);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (searchResults.isEmpty) {
        emit(RecipeTabInitial());
      } else {
        emit(RecipeTabLoaded(recipeCardList: searchResults));
      }
    } on Failure catch (e) {
      emit(RecipTabError(message: e.toString()));
    }
  }

  Future<void> _handleDeleteEntireCollection(
    DeleteEntireCollectionEvent event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      emit(RecipeTabLoading());

      await _database.deleteAllRecipes();
    } on Failure catch (e) {
      emit(RecipTabError(message: e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<RecipeTabState> emit,
  ) async {
    try {
      emit(RecipeTabLoading());

      await Future<void>.delayed(const Duration(seconds: 2));

      emit(RecipeTabInitial());
    } on Failure catch (e) {
      emit(RecipTabError(message: e.toString()));
    }
  }
}
