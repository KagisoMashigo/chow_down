abstract class SearchEvent {
  const SearchEvent();
}

class SearchRecipes extends SearchEvent {
  final String query;

  const SearchRecipes({
    required this.query,
  });

  @override
  String toString() {
    return 'SearchRecipe{url: $query}';
  }
}

// Needs to be moved as it is not specific to Searchion
class Refresh extends SearchEvent {
  const Refresh();
}
