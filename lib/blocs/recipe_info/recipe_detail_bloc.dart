// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_detail_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_detail_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  RecipeDetailBloc(this._recipeRepository, this._database)
      : super(RecipeInfoInitial()) {
    on<FetchRecipe>(_handleFetchRecipe);
    on<SaveRecipe>(_handleSaveRecipe);
    on<FetchRecipeInformation>(_handleFetchRecipeInformation);
  }

  final RemoteRecipe _recipeRepository;
  final FirestoreDatabase _database;

  Future<void> _handleFetchRecipe(
    FetchRecipe event,
    Emitter<RecipeDetailState> emit,
  ) async {
    try {
      printDebug('Fetching recipe with id: ${event.id} and url: ${event.url}');
      emit(RecipeInfoLoading(id: event.id, url: event.url));

      final hasMatch = event.savedRecipes
              ?.any((element) => element.sourceUrl == event.url) ??
          false;

      final savedRecipe = hasMatch
          ? event.savedRecipes
              ?.firstWhere((element) => element.sourceUrl == event.url)
          : null;

      if (event.savedRecipes != null && savedRecipe != null) {
        printDebug(
          'Recipe fetched successfully from database with id: ${event.id}',
          colour: DebugColour.green,
        );
        emit(RecipeInfoLoaded(recipe: savedRecipe));
      } else {
        final recipe = await _recipeRepository.getExistingRecipe(
          event.id,
          event.url,
        );

        printDebug(
          'Recipe fetched successfully from API with id: ${recipe.id}',
          colour: DebugColour.green,
        );
        emit(RecipeInfoLoaded(recipe: recipe));
      }
    } on Failure catch (e, stack) {
      printAndLog(
        e,
        'Fetching recipe failed for id: ${event.id}, url: ${event.url}, reason: $stack',
      );
      emit(
        RecipeInfoError(
          message: e.toString(),
          id: event.id,
          url: event.url,
        ),
      );
    }
  }

  Future<void> _handleSaveRecipe(
    SaveRecipe event,
    Emitter<RecipeDetailState> emit,
  ) async {
    try {
      printDebug('Saving recipe with id: ${event.recipe.id}');
      await _database.saveRecipe(event.recipe);
      printDebug(
        'Recipe saved successfully with id: ${event.recipe.id}',
        colour: DebugColour.green,
      );
    } on Failure catch (e, stack) {
      printAndLog(
        e,
        'Saving recipe failed for id: ${event.recipe.id}, url: ${event.recipe.sourceUrl}, reason: $stack',
      );
      emit(RecipeInfoError(
        message: e.toString(),
        id: event.recipe.id,
        url: event.recipe.sourceUrl,
      ));
    }
  }

  Future<void> _handleFetchRecipeInformation(
    FetchRecipeInformation event,
    Emitter<RecipeDetailState> emit,
  ) async {
    try {
      printDebug(
        'Fetching recipe information with id: ${event.id} and url: ${event.sourceUrl}',
      );
      emit(RecipeInfoLoading(id: event.id, url: event.sourceUrl));

      final Recipe recipe = await _recipeRepository.getExistingRecipe(
        event.id,
        event.sourceUrl,
      );

      printDebug(
        'Recipe information fetched successfully with id: ${recipe.id}',
        colour: DebugColour.green,
      );
      emit(RecipeInfoLoaded(recipe: recipe));
    } on Failure catch (e, stack) {
      printAndLog(
        e,
        'Fetching recipe information failed for id: ${event.id}, url: ${event.sourceUrl}, reason: $stack',
      );
      emit(RecipeInfoError(
        message: e.toString(),
        id: event.id,
        url: event.sourceUrl,
      ));
    }
  }
}
