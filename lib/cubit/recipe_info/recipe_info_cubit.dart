// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';

part 'recipe_info_state.dart';

class RecipeInfoCubit extends Cubit<RecipeInfoState> {
  RecipeInfoCubit(this._recipeRepository) : super(RecipeInfoInitial());

  final RemoteRecipe _recipeRepository;

  Future<void> fetchRecipeInformation(id, sourceUrl) async {
    try {
      emit(RecipeInfoLoading());

      final Recipe recipe =
          await _recipeRepository.getRecipeInformation(id, sourceUrl);
      // print('extracted recipe ${sourceUrl}');

      emit(RecipeInfoLoaded(recipe));
    } on Failure {
      emit(RecipInfoError('API error when fetching data'));
    }
  }
}
