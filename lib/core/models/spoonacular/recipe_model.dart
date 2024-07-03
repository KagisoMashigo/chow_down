// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';

part 'recipe_model.g.dart';

@JsonSerializable(explicitToJson: true)
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
  final String? image;
  final String? imageType;
  final String? summary;
  final List<String>? cuisines;
  final List<String>? dishTypes;
  final List<String>? diets;
  final List<String>? occasions;
  final String? instructions;
  final List<AnalyzedInstruction>? analyzedInstructions;
  final String? originalId;
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
    this.instructions,
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
      spoonacularScore: (snapshot['spoonacularScore'] as num?)?.toDouble(),
      healthScore: snapshot['healthScore'] as int?,
      creditsText: snapshot['creditsText'] as String?,
      license: snapshot['license'] as String?,
      sourceName: snapshot['sourceName'] as String?,
      pricePerServing: (snapshot['pricePerServing'] as num?)?.toDouble(),
      extendedIngredients: (snapshot['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => ExtendedIngredients.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: snapshot['id'] as int,
      title: snapshot['title'] as String,
      readyInMinutes: snapshot['readyInMinutes'] as int?,
      servings: snapshot['servings'] as int?,
      sourceUrl: snapshot['sourceUrl'] as String?,
      image: snapshot['image'] as String?,
      imageType: snapshot['imageType'] as String?,
      summary: snapshot['summary'] as String?,
      cuisines: (snapshot['cuisines'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dishTypes: (snapshot['dishTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      diets: (snapshot['diets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      occasions: (snapshot['occasions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      instructions: snapshot['instructions'] as String?,
      analyzedInstructions: (snapshot['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => AnalyzedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalId: snapshot['originalId'] as String?,
      spoonacularSourceUrl: snapshot['spoonacularSourceUrl'] as String?,
    );
  }

  Recipe copyWith({
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? dairyFree,
    bool? veryHealthy,
    bool? cheap,
    bool? veryPopular,
    bool? sustainable,
    int? weightWatcherSmartPoints,
    String? gaps,
    bool? lowFodmap,
    int? aggregateLikes,
    double? spoonacularScore,
    int? healthScore,
    String? creditsText,
    String? license,
    String? sourceName,
    double? pricePerServing,
    List<ExtendedIngredients>? extendedIngredients,
    int? id,
    String? title,
    int? readyInMinutes,
    int? servings,
    String? sourceUrl,
    String? image,
    String? imageType,
    String? summary,
    List<String>? cuisines,
    List<String>? dishTypes,
    List<String>? diets,
    List<String>? occasions,
    String? instructions,
    List<AnalyzedInstruction>? analyzedInstructions,
    String? originalId,
    String? spoonacularSourceUrl,
  }) {
    return Recipe(
      vegetarian: vegetarian ?? this.vegetarian,
      vegan: vegan ?? this.vegan,
      glutenFree: glutenFree ?? this.glutenFree,
      dairyFree: dairyFree ?? this.dairyFree,
      veryHealthy: veryHealthy ?? this.veryHealthy,
      cheap: cheap ?? this.cheap,
      veryPopular: veryPopular ?? this.veryPopular,
      sustainable: sustainable ?? this.sustainable,
      weightWatcherSmartPoints:
          weightWatcherSmartPoints ?? this.weightWatcherSmartPoints,
      gaps: gaps ?? this.gaps,
      lowFodmap: lowFodmap ?? this.lowFodmap,
      aggregateLikes: aggregateLikes ?? this.aggregateLikes,
      spoonacularScore: spoonacularScore ?? this.spoonacularScore,
      healthScore: healthScore ?? this.healthScore,
      creditsText: creditsText ?? this.creditsText,
      license: license ?? this.license,
      sourceName: sourceName ?? this.sourceName,
      pricePerServing: pricePerServing ?? this.pricePerServing,
      extendedIngredients: extendedIngredients ?? this.extendedIngredients,
      id: id ?? this.id,
      title: title ?? this.title,
      readyInMinutes: readyInMinutes ?? this.readyInMinutes,
      servings: servings ?? this.servings,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      image: image ?? this.image,
      imageType: imageType ?? this.imageType,
      summary: summary ?? this.summary,
      cuisines: cuisines ?? this.cuisines,
      dishTypes: dishTypes ?? this.dishTypes,
      diets: diets ?? this.diets,
      occasions: occasions ?? this.occasions,
      instructions: instructions ?? this.instructions,
      analyzedInstructions: analyzedInstructions ?? this.analyzedInstructions,
      originalId: originalId ?? this.originalId,
      spoonacularSourceUrl: spoonacularSourceUrl ?? this.spoonacularSourceUrl,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  String toString() {
    return '{vegetarian: $vegetarian, vegan: $vegan, glutenFree: $glutenFree, dairyFree: $dairyFree, veryPopular: $veryPopular, sourceName: $sourceName, id: $id, title: $title, readyInMinutes: $readyInMinutes, servings: $servings, sourceUrl: $sourceUrl, diets: $diets, originalId: $originalId, spoonacularSourceUrl: $spoonacularSourceUrl}';
  }
}
