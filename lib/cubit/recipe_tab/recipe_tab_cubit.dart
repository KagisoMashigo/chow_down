import 'package:bloc/bloc.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_home_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:equatable/equatable.dart';

part 'recipe_tab_state.dart';

class RecipeTabCubit extends Cubit<RecipeTabState> {
  RecipeTabCubit(this._recipeHomeRepository) : super(RecipeTabInitial());

  final RemoteHomeRecipe _recipeHomeRepository;

  Future<void> fetchHomeRecipesList() async {
    try {
      emit(RecipeTabLoading());

      final searchResults = await _recipeHomeRepository.getLatestRecipe();

      emit(RecipeTabLoaded(searchResults));
    } on Failure {
      emit(RecipTabError('API error when fetching data'));
    }
  }
}
