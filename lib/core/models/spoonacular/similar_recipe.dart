import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Similar {
  final String id;
  final String name;
  final String? image;
  final String? readyInMinutes;
  final String? servings;
  Similar({
    required this.id,
    required this.name,
    this.image,
    this.readyInMinutes,
    this.servings,
  });
  factory Similar.fromJson(Map<String, dynamic> json) {
    return Similar(
      id: json['id'].toString(),
      name: json['title'],
      image:
          "https://spoonacular.com/recipeImages/${json['id']}-556x370.${json['imageType']}",
      readyInMinutes: json['readyInMinutes'].toString(),
      servings: json['servings'].toString(),
    );
  }
}

@JsonSerializable()
class SimilarList {
  final List<Similar> list;
  SimilarList({
    required this.list,
  });

  factory SimilarList.fromJson(List<dynamic> json) {
    return SimilarList(
      list: json.map((data) => Similar.fromJson(data)).toList(),
    );
  }
}
