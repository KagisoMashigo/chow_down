import 'package:bloc/bloc.dart';
import 'package:chow_down/core/data/sources/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/core/data/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final RemoteSearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(SearchInitial());

  Future<void> fetchRecipesList(String query) async {
    try {
      emit(SearchLoading());

      final searchResults = await _searchRepository.getRecipesList(query);

      emit(SearchLoaded(searchResults));
    } on Failure {
      emit(SearchError('API error when fetching results'));
    }
  }
}
