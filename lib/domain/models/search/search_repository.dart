import 'package:chow_down/domain/models/search/search_result_model.dart';

abstract class SearchResultRepository {
  Future<SearchResultList> getRecipesList();
}
