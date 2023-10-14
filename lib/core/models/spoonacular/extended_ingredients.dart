// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/measures.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ExtendedIngredients {
  final int id;
  final String? aisle;
  final String? image;
  final String? consistency;
  final String? name;
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

  factory ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    return ExtendedIngredients(
      id: json['id'],
      aisle: json['aisle'],
      image: json['image'],
      consistency: json['consistency'],
      name: json['name'],
      nameClean: json['nameClean'],
      original: json['original'],
      originalString: json['originalString'],
      originalName: json['originalName'],
      amount: json['amount'],
      unit: json['unit'],
      meta: json['meta'],
      metaInformation: json['metaInformation'],
      measures: Measures.fromJson(json['measures']),
    );
  }

  toJson() => {
        'id': id,
        'aisle': aisle,
        'image': image,
        'consistency': consistency,
        'name': name,
        'nameClean': nameClean,
        'original': original,
        'originalString': originalString,
        'originalName': originalName,
        'amount': amount,
        'unit': unit,
        'meta': meta,
        'metaInformation': metaInformation,
        'measures': measures?.toJson(),
      };
}
