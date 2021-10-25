import 'package:chow_down/core/data/models/spoonacular/search_autocomplete_model.dart';
import 'package:equatable/equatable.dart';

enum Status { loading, initial, success }

class SearchPageState extends Equatable {
  final Status status;
  final String searchText;
  final List<SearchAutoComplete> searchList;
  const SearchPageState({
    this.status,
    this.searchText,
    this.searchList,
  });
  factory SearchPageState.initial() {
    return SearchPageState(
        status: Status.initial, searchText: '', searchList: []);
  }
  @override
  List<Object> get props => [
        status,
        searchText,
        searchList,
      ];

  SearchPageState copyWith({
    Status status,
    String searchText,
    List<SearchAutoComplete> searchList,
  }) {
    return SearchPageState(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
      searchList: searchList ?? this.searchList,
    );
  }
}
