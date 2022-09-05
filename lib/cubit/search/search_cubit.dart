// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final RemoteSearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  Future<void> fetchSearchResults(String query) async {
    try {
      emit(SearchLoading());

      final searchResults = await _searchRepository.getRecipesList(query);

      emit(SearchLoaded(searchResults));
    } on Failure catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
