// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

part 'recipe_info_state.dart';

class RecipeInfoCubit extends Cubit<RecipeInfoState> {
  RecipeInfoCubit(this._recipeRepository, this._database)
      : super(RecipeInfoInitial());

  final RemoteRecipe _recipeRepository;

  final FirestoreDatabase _database;

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      emit(RecipeInfoLoading());

      await _database.saveRecipes(recipe);
      // await Future<void>.delayed(const Duration(milliseconds: 50));
      // if (searchResults.isEmpty) {
      //   emit(RecipeInfoInitial());
      // } else {
      //   emit(RecipeInfoLoaded(recipe));
      // }

      emit(RecipeInfoLoaded(recipe));
    } on Failure catch (e) {
      emit(RecipInfoError(e.toString()));
    }
  }

  Future<void> fetchRecipe(int id, String url) async {
    try {
      emit(RecipeInfoLoading());

      // TODO: optimise so it isn't pulling the whole list
      final List<Recipe> searchResults = await _database.retrieveSavedRecipes();

      if (searchResults.isEmpty) {
        emit(RecipeInfoInitial());
      }

      if (searchResults.isNotEmpty) {
        for (var savedRecipe in searchResults) {
          if (savedRecipe.sourceUrl == url) {
            final Recipe recipe =
                searchResults.firstWhere((recipe) => recipe.sourceUrl == url);
            emit(RecipeInfoLoaded(recipe));
            return;
          }
        }
      }

      final Recipe recipe =
          await _recipeRepository.getRecipeInformation(id, url);
      emit(RecipeInfoLoaded(recipe));
    } on Failure catch (e) {
      emit(RecipInfoError(e.toString()));
    }
  }

  Future<void> fetchRecipeInformation(id, sourceUrl) async {
    try {
      emit(RecipeInfoLoading());

      final Recipe recipe =
          await _recipeRepository.getRecipeInformation(id, sourceUrl);

      emit(RecipeInfoLoaded(recipe));
    } on Failure {
      emit(RecipInfoError('API error when fetching data'));
    }
  }
}
