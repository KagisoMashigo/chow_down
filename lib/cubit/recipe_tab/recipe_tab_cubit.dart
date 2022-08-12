// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

// 🌎 Project imports:

part 'recipe_tab_state.dart';

class RecipeTabCubit extends Cubit<RecipeTabState> {
  RecipeTabCubit(
    this._database,
  ) : super(RecipeTabInitial());

  final FirestoreDatabase _database;

  Future<void> fetchHomeRecipesList() async {
    try {
      emit(RecipeTabLoading());

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (searchResults.isEmpty) {
        emit(RecipeTabInitial());
      } else {
        emit(RecipeTabLoaded(searchResults));
      }
    } on Failure catch (e) {
      emit(RecipTabError(e.toString()));
    }
  }

  Future<void> deleteRecipeFromCollection(Recipe recipe) async {
    try {
      emit(RecipeTabLoading());

      await _database.deleteRecipe(recipe);

      await Future<void>.delayed(const Duration(milliseconds: 50));

      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      if (searchResults.isEmpty) {
        emit(RecipeTabInitial());
      } else {
        emit(RecipeTabLoaded(searchResults));
      }
    } on Failure catch (e) {
      emit(RecipTabError(e.toString()));
    }
  }
}
