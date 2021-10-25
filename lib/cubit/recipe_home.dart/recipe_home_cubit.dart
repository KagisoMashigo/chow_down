import 'package:bloc/bloc.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_home_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:equatable/equatable.dart';

part 'recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  RecipeHomeCubit(this._recipeHomeRepository) : super(RecipeHomeInitial());

  final RemoteHomeRecipe _recipeHomeRepository;

  Future<void> fetchHomeRecipesList() async {
    try {
      emit(RecipeHomeLoading());

      final searchResults = await _recipeHomeRepository.getLatestRecipe();

      emit(RecipeHomeLoaded(searchResults));
    } on Failure {
      emit(RecipeHomeError('API error when fetching data'));
    }
  }
}
