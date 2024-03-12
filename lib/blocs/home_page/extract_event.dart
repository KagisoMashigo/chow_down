abstract class ExtractEvent {
  const ExtractEvent();
}

class ExtractRecipe extends ExtractEvent {
  final String url;

  const ExtractRecipe({
    required this.url,
  });

  @override
  String toString() {
    return 'ExtractRecipe{url: $url}';
  }
}

// Needs to be moved as it is not specific to extraction
class Refresh extends ExtractEvent {
  const Refresh();
}

class RecipeExtracted extends ExtractEvent {
  const RecipeExtracted();
}
