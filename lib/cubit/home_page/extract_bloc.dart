// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/home_page/extract_event.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

part 'extract_state.dart';

class ExtractBloc extends Bloc<ExtractEvent, ExtractState> {
  final RemoteRecipe _recipeRepository;

  ExtractBloc(
    this._recipeRepository,
  ) : super(ExtractInitial()) {
    on<ExtractRecipe>(_handleExtractRecipe);
    on<Refresh>(_handleRefreshExtract);
  }

  Future<void> _handleExtractRecipe(
    ExtractRecipe event,
    Emitter<ExtractState> emit,
  ) async {
    try {
      emit(ExtractPending());

      if (StringHelper.isUrlValid(event.url)) {
        final Recipe extractedResult =
            await _recipeRepository.getExtractedRecipe(event.url);

        emit(ExtractLoaded(extractedResult));
      } else {
        emit(ExtractError('The URL provided is invalid or empty', null));
      }
    } on Failure catch (e) {
      emit(ExtractError(e.toString(), e.code));
    }
  }

  Future<void> _handleRefreshExtract(
    Refresh event,
    Emitter<ExtractState> emit,
  ) async {
    try {
      emit(ExtractPending());

      Future.delayed(Duration(seconds: 2));

      emit(ExtractInitial());
    } on Failure catch (e) {
      emit(ExtractError(e.toString(), e.code!));
    }
  }
}
