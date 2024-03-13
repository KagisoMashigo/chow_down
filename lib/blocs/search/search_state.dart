// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final RecipeCardInfoList searchResultList;

  const SearchLoaded({required this.searchResultList});

  @override
  String toString() => 'SearchLoaded{searchResultList: $searchResultList}';
}

class SearchError extends SearchState {
  final String? message;

  const SearchError({this.message});

  @override
  String toString() => 'SearchError{message: $message}';
}
