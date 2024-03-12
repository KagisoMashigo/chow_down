// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:chow_down/blocs/search/search_event.dart';
import 'package:equatable/equatable.dart';

// 🌎 Project imports:
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';

part 'search_state.dart';

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
      emit(SearchLoading());

      if (event.query.isNotEmpty) {
        final searchResults =
            await _searchRepository.getRecipesList(event.query);
        emit(SearchLoaded(searchResults));
      } else {
        emit(SearchError('The query provided is invalid or empty'));
      }
    } on Failure catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _handleRefresh(
    Refresh event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());

      Future.delayed(Duration(seconds: 2));

      emit(SearchInitial());
    } on Failure catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
