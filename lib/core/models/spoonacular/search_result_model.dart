class RecipeCardInfo {
  final int id;
  final String name;
  final String image;
  final String sourceUrl;
  final int readyInMinutes;
  final bool vegetarian;
  final int servings;
  RecipeCardInfo({
    this.id,
    this.name,
    this.image,
    this.sourceUrl,
    this.readyInMinutes,
    this.vegetarian,
    this.servings,
  });
  factory RecipeCardInfo.fromJson(Map<String, dynamic> json) {
    return RecipeCardInfo(
      id: json['id'],
      name: json['title'],
      image: json['image'],
      sourceUrl: json['sourceUrl'],
      readyInMinutes: json['readyInMinutes'],
      vegetarian: json['vegetarian'],
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
