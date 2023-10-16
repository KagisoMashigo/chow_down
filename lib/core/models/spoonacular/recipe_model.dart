// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class Recipe {
  final bool? vegetarian;
  final bool? vegan;
  final bool? glutenFree;
  final bool? dairyFree;
  final bool? veryHealthy;
  final bool? cheap;
  final bool? veryPopular;
  final bool? sustainable;
  final int? weightWatcherSmartPoints;
  final String? gaps;
  final bool? lowFodmap;
  final int? aggregateLikes;
  final double? spoonacularScore;
  final int? healthScore;
  final String? creditsText;
  final String? license;
  final String? sourceName;
  final double? pricePerServing;
  final List<ExtendedIngredients>? extendedIngredients;
  final int id;
  final String title;
  final int? readyInMinutes;
  final int? servings;
  final String? sourceUrl;
  final String image;
  final String? imageType;
  final String? summary;
  final List<dynamic>? cuisines;
  final List<dynamic>? dishTypes;
  final List<dynamic>? diets;
  final List<dynamic>? occasions;
  final String instructions;
  final List<AnalyzedInstruction>? analyzedInstructions;
  final dynamic originalId;
  final String? spoonacularSourceUrl;

  Recipe({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.lowFodmap,
    this.aggregateLikes,
    this.spoonacularScore,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    this.extendedIngredients,
    required this.id,
    required this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    required this.image,
    this.imageType,
    this.summary,
    this.cuisines,
    this.dishTypes,
    this.diets,
    this.occasions,
    required this.instructions,
    this.analyzedInstructions,
    required this.originalId,
    this.spoonacularSourceUrl,
  });

  factory Recipe.fromFirestore(Map<String, dynamic> snapshot) {
    return Recipe(
      vegetarian: snapshot['vegetarian'] as bool?,
      vegan: snapshot['vegan'] as bool?,
      glutenFree: snapshot['glutenFree'] as bool?,
      dairyFree: snapshot['dairyFree'] as bool?,
      veryHealthy: snapshot['veryHealthy'] as bool?,
      cheap: snapshot['cheap'] as bool?,
      veryPopular: snapshot['veryPopular'] as bool?,
      sustainable: snapshot['sustainable'] as bool?,
      weightWatcherSmartPoints: snapshot['weightWatcherSmartPoints'] as int?,
      gaps: snapshot['gaps'] as String?,
      lowFodmap: snapshot['lowFodmap'] as bool?,
      aggregateLikes: snapshot['aggregateLikes'] as int?,
      spoonacularScore: snapshot['spoonacularScore'] as double?,
      healthScore: snapshot['healthScore'] as int?,
      creditsText: snapshot['creditsText'] as String?,
      license: snapshot['license'] as String?,
      sourceName: snapshot['sourceName'] as String?,
      pricePerServing: (snapshot['pricePerServing'] as double?) ?? 0.0,
      extendedIngredients: (snapshot['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => ExtendedIngredients.fromJson(e))
          .toList(),
      id: snapshot['id'] as int,
      title: snapshot['title'] as String,
      readyInMinutes: snapshot['readyInMinutes'] as int?,
      servings: snapshot['servings'] as int?,
      sourceUrl: snapshot['sourceUrl'] as String?,
      image: snapshot['image'] as String,
      imageType: snapshot['imageType'] as String?,
      summary: snapshot['summary'] as String?,
      cuisines: (snapshot['cuisines'] as List<dynamic>?)?.cast<String>(),
      dishTypes: (snapshot['dishTypes'] as List<dynamic>?)?.cast<String>(),
      diets: (snapshot['diets'] as List<dynamic>?)?.cast<String>(),
      occasions: (snapshot['occasions'] as List<dynamic>?)?.cast<String>(),
      instructions: snapshot['instructions'] as String,
      analyzedInstructions: (snapshot['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => AnalyzedInstruction.fromJson(e))
          .toList(),
      originalId: snapshot['originalId'],
      spoonacularSourceUrl: snapshot['spoonacularSourceUrl'] as String?,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
