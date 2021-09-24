import 'package:bloc/bloc.dart';
import 'package:chow_down/pages/search/cubit/search_page_state.dart';
import 'package:chow_down/services/spoonacular_api/search_endpoint.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(SearchPageState.initial());
  final repo = SearchRepo();
  void textChange(String text) async {
    emit(state.copyWith(status: Status.loading, searchText: text));
    final list = await repo.getAutoCompleteList(text);
    emit(state.copyWith(status: Status.success, searchList: list.list));
  }
}
