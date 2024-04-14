// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  RecipeInfoBloc(this._recipeRepository, this._database)
      : super(RecipeInfoInitial()) {
    on<FetchRecipe>(_handleFetchRecipe);
    on<SaveRecipe>(_handleSaveRecipe);
    on<FetchRecipeInformation>(_handleFetchRecipeInformation);
  }

  final RemoteRecipe _recipeRepository;

  final FirestoreDatabase _database;

  Future<void> _handleFetchRecipe(
    FetchRecipe event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading(id: event.id, url: event.url));

      final Recipe recipe = await _recipeRepository.getExistingRecipe(
        event.id,
        event.url,
      );

      emit(RecipeInfoLoaded(recipe: recipe));
    } on Failure catch (e) {
      emit(
          RecipeInfoError(message: e.toString(), id: event.id, url: event.url));
    }
  }

  Future<void> _handleSaveRecipe(
    SaveRecipe event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading(
        id: event.recipe.id,
        url: event.recipe.sourceUrl,
      ));

      await _database.saveRecipe(event.recipe);

      emit(RecipeInfoLoaded(recipe: event.recipe));
    } on Failure catch (e) {
      emit(RecipeInfoError(
        message: e.toString(),
        id: event.recipe.id,
        url: event.recipe.sourceUrl,
      ));
    }
  }

  Future<void> _handleFetchRecipeInformation(
    FetchRecipeInformation event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading(
        id: event.id,
        url: event.sourceUrl,
      ));

      final Recipe recipe = await _recipeRepository.getExistingRecipe(
        event.id,
        event.sourceUrl,
      );

      emit(RecipeInfoLoaded(recipe: recipe));
    } on Failure catch (e) {
      emit(RecipeInfoError(
        message: e.toString(),
        id: event.id,
        url: event.sourceUrl,
      ));
    }
  }

  // Future<void> _handleRefresh(
  //   Refresh event,
  //   Emitter<RecipeInfoState> emit,
  // ) async {
  //   try {
  //     emit(RecipeInfoLoading());

  //     emit(RecipeInfoInitial());
  //   } on Failure catch (e) {
  //     emit(RecipeInfoError(message: e.toString()));
  //   }
  // }
}
