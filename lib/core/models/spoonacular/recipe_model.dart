// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class Recipe {
  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  int? weightWatcherSmartPoints;
  String? gaps;
  bool? lowFodmap;
  int? aggregateLikes;
  double? spoonacularScore;
  int? healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double? pricePerServing;
  List<ExtendedIngredients>? extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  String? image;
  String? imageType;
  String? summary;
  List<dynamic>? cuisines;
  List<dynamic>? dishTypes;
  List<dynamic>? diets;
  List<dynamic>? occasions;
  String instructions;
  List<AnalyzedInstruction>? analyzedInstructions;
  dynamic originalId;
  String? spoonacularSourceUrl;

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
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.image,
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

  factory Recipe.fromFirestore(
    Map<String, dynamic> snapshot,
  ) {
    return Recipe(
      vegetarian: snapshot['vegetarian'],
      vegan: snapshot['vegan'] as bool,
      glutenFree: snapshot['glutenFree'] as bool,
      dairyFree: snapshot['dairyFree'] as bool,
      veryHealthy: snapshot['veryHealthy'] as bool,
      cheap: snapshot['cheap'] as bool,
      veryPopular: snapshot['veryPopular'] as bool,
      sustainable: snapshot['sustainable'] as bool,
      weightWatcherSmartPoints: snapshot['weightWatcherSmartPoints'] as int,
      gaps: snapshot['gaps'] as String,
      lowFodmap: snapshot['lowFodmap'] as bool,
      aggregateLikes: snapshot['aggregateLikes'] as int,
      spoonacularScore: snapshot['spoonacularScore'] as double,
      healthScore: snapshot['healthScore'] as int,
      creditsText: snapshot['creditsText'] as String,
      license: snapshot['license'] as String,
      sourceName: snapshot['sourceName'] as String,
      pricePerServing: (snapshot['pricePerServing'] ?? 0).toDouble(),
      extendedIngredients: (snapshot['extendedIngredients'] as List<dynamic>)
          .map((e) => ExtendedIngredients.fromJson(e))
          .toList(),
      id: snapshot['id'] as int,
      title: snapshot['title'] as String,
      readyInMinutes: snapshot['readyInMinutes'] as int,
      servings: snapshot['servings'] as int,
      sourceUrl: snapshot['sourceUrl'] as String,
      image: snapshot['image'] as String,
      imageType: snapshot['imageType'] as String,
      summary: snapshot['summary'] as String,
      cuisines: snapshot['cuisines'] as List<dynamic>,
      dishTypes: snapshot['dishTypes'] as List<dynamic>,
      diets: snapshot['diets'] as List<dynamic>,
      occasions: snapshot['occasions'] as List<dynamic>,
      instructions: snapshot['instructions'] as String,
      analyzedInstructions: (snapshot['analyzedInstructions'] as List<dynamic>)
          .map((e) => AnalyzedInstruction.fromJson(e))
          .toList(),
      originalId: snapshot['originalId'] as dynamic,
      spoonacularSourceUrl: snapshot['spoonacularSourceUrl'] as String,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
