// 📦 Package imports:
import 'package:bloc/bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/search/search_event.dart';
import 'package:chow_down/blocs/search/search_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/plugins/debugHelper.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final RemoteSearchRepository _searchRepository;

  SearchBloc(this._searchRepository) : super(SearchInitial()) {
    on<SearchRecipes>(_handleSearchRecipes);
    on<Refresh>(_handleRefresh);
  }

  Future<void> _handleSearchRecipes(
    SearchRecipes event,
    Emitter<SearchState> emit,
  ) async {
    try {
      printDebug('Searching recipes with query: ${event.query}');
      emit(SearchLoading());

      if (event.query.isNotEmpty) {
        final searchResults =
            await _searchRepository.getRecipesList(event.query);
        printDebug('Search completed successfully for query: ${event.query}');
        emit(SearchLoaded(searchResultList: searchResults));
      } else {
        printDebug('The query provided is invalid or empty: ${event.query}');
        emit(SearchError(message: 'The query provided is invalid or empty'));
      }
    } on Failure catch (e, stack) {
      printAndLog(e, 'Search failed for query: ${event.query}, reason: $stack');
      emit(SearchError(message: e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<SearchState> emit,
  ) async {
    try {
      printDebug('Refreshing search results');
      emit(SearchLoading());

      await Future.delayed(Duration(seconds: 2));

      printDebug('Search refresh completed');
      emit(SearchInitial());
    } on Failure catch (e, stack) {
      printAndLog(e, 'Refresh search results failed, reason: $stack');
      emit(SearchError(message: e.toString()));
    }
  }
}
