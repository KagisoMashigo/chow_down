import 'package:bloc/bloc.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:equatable/equatable.dart';

part 'recipe_info_state.dart';

class RecipeTabCubit extends Cubit<RecipeInfoState> {
  RecipeTabCubit(this._recipeRepository) : super(RecipeTabInitial());

  final RemoteRecipe _recipeRepository;

  Future<void> fetchHomeRecipesList() async {
    try {
      emit(RecipeTabLoading());

      final searchResults = await _recipeRepository.getRecipeInformation();

      emit(RecipeInfoLoaded(searchResults));
    } on Failure {
      emit(RecipInfoError('API error when fetching data'));
    }
  }
}
