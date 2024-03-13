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
    on<Refresh>(_handleRefresh);
  }

  final RemoteRecipe _recipeRepository;

  final FirestoreDatabase _database;

  Future<void> _handleFetchRecipe(
    FetchRecipe event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading());

      final Recipe recipe = await _recipeRepository.getExistingRecipe(
        event.id,
        event.url,
      );

      emit(RecipeInfoLoaded(recipe));
    } on Failure catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }

  Future<void> _handleSaveRecipe(
    SaveRecipe event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading());

      await _database.saveRecipe(event.recipe);

      emit(RecipeInfoLoaded(event.recipe));
    } on Failure catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }

  Future<void> _handleFetchRecipeInformation(
    FetchRecipeInformation event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading());

      final Recipe recipe = await _recipeRepository.getExistingRecipe(
        event.id,
        event.sourceUrl,
      );

      emit(RecipeInfoLoaded(recipe));
    } on Failure catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<RecipeInfoState> emit,
  ) async {
    try {
      emit(RecipeInfoLoading());

      emit(RecipeInfoInitial());
    } on Failure catch (e) {
      emit(RecipeInfoError(e.toString()));
    }
  }
}

// class RecipeInfoCubit extends Cubit<RecipeInfoState> {
//   RecipeInfoCubit(this._recipeRepository, this._database)
//       : super(RecipeInfoInitial());

//   final RemoteRecipe _recipeRepository;

//   final FirestoreDatabase _database;

//   Future<void> saveRecipe(Recipe recipe) async {
//     try {
//       // emit(RecipeInfoLoading());

//       await _database.saveRecipe(recipe);

//       emit(RecipeInfoLoaded(recipe));
//     } on Failure catch (e) {
//       emit(RecipInfoError(e.toString()));
//     }
//   }

//   Future<void> fetchRecipe(int id, String url) async {
//     try {
//       emit(RecipeInfoLoading());

//       // TODO: optimise so it isn't pulling the whole list
//       final List<Recipe> searchResults = await _database.retrieveSavedRecipes();

//       if (searchResults.isEmpty) {
//         emit(RecipeInfoInitial());
//       }

//       if (searchResults.isNotEmpty) {
//         for (var savedRecipe in searchResults) {
//           if (savedRecipe.sourceUrl == url) {
//             final Recipe recipe =
//                 searchResults.firstWhere((recipe) => recipe.sourceUrl == url);
//             emit(RecipeInfoLoaded(recipe));
//             return;
//           }
//         }
//       }

//       final Recipe recipe = await _recipeRepository.getExistingRecipe(id, url);
//       emit(RecipeInfoLoaded(recipe));
//     } on Failure catch (e) {
//       emit(RecipInfoError(e.toString()));
//     }
//   }

//   Future<void> fetchRecipeInformation(id, sourceUrl) async {
//     try {
//       emit(RecipeInfoLoading());

//       final Recipe recipe =
//           await _recipeRepository.getExistingRecipe(id, sourceUrl);

//       emit(RecipeInfoLoaded(recipe));
//     } on Failure {
//       emit(RecipInfoError('API error when fetching data'));
//     }
//   }
// }
