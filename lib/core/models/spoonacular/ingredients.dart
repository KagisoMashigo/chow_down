import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Ingredient {
  final int id;
  final String name;
  final String? localizedName;
  final String? image;

  Ingredient({
    required this.id,
    required this.name,
    this.localizedName,
    this.image,
  });

  factory Ingredient.fromJson(json) => Ingredient(
        id: json['id'] as int,
        name: json['name'] as String,
        localizedName: json['localizedName'] as String,
        image: json['image'] as String,
      );

  toJson() => {
        'id': id,
        'name': name,
        'localizedName': localizedName,
        'image': image,
      };
}
