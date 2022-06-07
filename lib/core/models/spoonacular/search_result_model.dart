class RecipeCardInfo {
  final int id;
  final String title;
  final String image;
  final String sourceUrl;
  final int readyInMinutes;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final int servings;
  RecipeCardInfo({
    this.id,
    this.title,
    this.image,
    this.sourceUrl,
    this.readyInMinutes,
    this.vegetarian,
    this.glutenFree,
    this.vegan,
    this.servings,
  });
  factory RecipeCardInfo.fromJson(Map<String, dynamic> json) {
    return RecipeCardInfo(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      glutenFree: json['glutenFree'],
      sourceUrl: json['sourceUrl'],
      readyInMinutes: json['readyInMinutes'],
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      servings: json['servings'],
    );
  }
}

class RecipeCardInfoList {
  final List<RecipeCardInfo> list;
  RecipeCardInfoList({
    this.list,
  });

  factory RecipeCardInfoList.fromJson(List<dynamic> json) {
    return RecipeCardInfoList(
      list: json.map((data) => RecipeCardInfo.fromJson(data)).toList(),
    );
  }
}
