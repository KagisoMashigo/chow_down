// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/measures.dart';

part 'extended_ingredients.g.dart';

@JsonSerializable(explicitToJson: true)
class ExtendedIngredients {
  final int id;
  final String? aisle;
  final String? image;
  final String? consistency;
  final String name;
  final String? nameClean;
  final String? original;
  final String? originalString;
  final String? originalName;
  final double? amount;
  final String? unit;
  final List? meta;
  final List? metaInformation;
  final Measures? measures;

  ExtendedIngredients({
    required this.id,
    this.aisle,
    this.image,
    this.consistency,
    required this.name,
    this.nameClean,
    this.original,
    this.originalString,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.metaInformation,
    this.measures,
  });

  ExtendedIngredients copyWith({
    int? id,
    String? aisle,
    String? image,
    String? consistency,
    String? name,
    String? nameClean,
    String? original,
    String? originalString,
    String? originalName,
    double? amount,
    String? unit,
    List? meta,
    List? metaInformation,
    Measures? measures,
  }) {
    return ExtendedIngredients(
      id: id ?? this.id,
      aisle: aisle ?? this.aisle,
      image: image ?? this.image,
      consistency: consistency ?? this.consistency,
      name: name ?? this.name,
      nameClean: nameClean ?? this.nameClean,
      original: original ?? this.original,
      originalString: originalString ?? this.originalString,
      originalName: originalName ?? this.originalName,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      meta: meta ?? this.meta,
      metaInformation: metaInformation ?? this.metaInformation,
      measures: measures ?? this.measures,
    );
  }

  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientsFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedIngredientsToJson(this);
}
