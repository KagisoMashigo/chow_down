// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/home_page/extract_event.dart';
import 'package:chow_down/blocs/home_page/extract_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

class ExtractBloc extends Bloc<ExtractEvent, ExtractState> {
  final RemoteRecipe _recipeRepository;

  ExtractBloc(this._recipeRepository) : super(ExtractInitial()) {
    on<ExtractRecipe>(_handleExtractRecipe);
    on<RefreshHome>(_handleRefreshExtract);
  }

  Future<void> _handleExtractRecipe(
    ExtractRecipe event,
    Emitter<ExtractState> emit,
  ) async {
    try {
      printDebug('Attempting to extract recipe from URL: ${event.url}');
      emit(ExtractPending());

      if (StringHelper.isUrlValid(event.url)) {
        final Recipe extractedResult =
            await _recipeRepository.getExtractedRecipe(event.url);

        printDebug('Recipe extraction successful from URL: ${event.url}');

        emit(ExtractLoaded(extractedResult));
      } else {
        printDebug('Invalid or empty URL provided: ${event.url}');

        emit(ExtractError('The URL provided is invalid or empty', null));
      }
    } on Failure catch (e, stack) {
      printAndLog(
        e,
        'Recipe extraction failed for URL: ${event.url}, reason: $stack',
      );

      emit(ExtractError('Failed to extract recipe. Please try again.', e.code));
    }
  }

  Future<void> _handleRefreshExtract(
    RefreshHome event,
    Emitter<ExtractState> emit,
  ) async {
    try {
      printDebug('Refreshing extract...');
      emit(ExtractPending());

      await Future.delayed(Duration(seconds: 2));

      printDebug('Refresh complete, returning to initial state');
      emit(ExtractInitial());
    } on Failure catch (e, stack) {
      printAndLog(e, 'Refresh extract failed, reason: $stack');

      emit(ExtractError(e.toString(), e.code!));
    }
  }
}
