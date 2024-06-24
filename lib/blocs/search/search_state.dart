// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  String toString() => 'SearchInitial{}';

  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  String toString() => 'SearchLoading{}';

  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final RecipeCardInfoList searchResultList;

  const SearchLoaded({required this.searchResultList});

  @override
  String toString() => 'SearchLoaded{searchResultList: $searchResultList}';

  @override
  List<Object> get props => [searchResultList];
}

class SearchError extends SearchState {
  final String? message;

  const SearchError({this.message});

  @override
  String toString() => 'SearchError{message: $message}';

  @override
  List<Object> get props => [message ?? ''];
}
