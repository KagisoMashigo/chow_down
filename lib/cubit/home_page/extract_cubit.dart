// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';

part 'extract_state.dart';

class ExtractCubit extends Cubit<ExtractState> {
  final RemoteSearchRepository _searchRepository;

  ExtractCubit(this._searchRepository) : super(ExtractInitial());

  Future<void> refresh() async {
    try {
      emit(ExtractLoading());

      Future.delayed(Duration(seconds: 2));

      emit(ExtractInitial());
    } on Failure catch (e) {
      emit(ExtractError(e.toString(), e.code));
    }
  }

  Future<void> fetchExtractedResult(String url) async {
    try {
      emit(ExtractLoading());

      final Recipe extractedResult =
          await _searchRepository.getExtractedRecipe(url);

      emit(ExtractLoaded(extractedResult));
    } on Failure catch (e) {
      emit(ExtractError(e.toString(), e.code));
    }
  }
}
