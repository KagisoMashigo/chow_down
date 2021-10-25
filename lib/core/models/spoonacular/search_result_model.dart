class RecipeCardInfo {
  final int id;
  final String name;
  final String image;
  RecipeCardInfo({
    this.id,
    this.name,
    this.image,
  });
  factory RecipeCardInfo.fromJson(Map<String, dynamic> json) {
    return RecipeCardInfo(
      id: json['id'],
      name: json['title'],
      image: json['image'],
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
