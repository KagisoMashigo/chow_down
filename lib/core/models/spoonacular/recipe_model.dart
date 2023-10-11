// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

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
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // SnapshotOptions options,
  ) {
    final data = snapshot.data()!;
    return Recipe(
      vegetarian: data['vegetarian'],
      vegan: data['vegan'] as bool,
      glutenFree: data['glutenFree'] as bool,
      dairyFree: data['dairyFree'] as bool,
      veryHealthy: data['veryHealthy'] as bool,
      cheap: data['cheap'] as bool,
      veryPopular: data['veryPopular'] as bool,
      sustainable: data['sustainable'] as bool,
      weightWatcherSmartPoints: data['weightWatcherSmartPoints'] as int,
      gaps: data['gaps'] as String,
      lowFodmap: data['lowFodmap'] as bool,
      aggregateLikes: data['aggregateLikes'] as int,
      spoonacularScore: data['spoonacularScore'] as double,
      healthScore: data['healthScore'] as int,
      creditsText: data['creditsText'] as String,
      license: data['license'] as String,
      sourceName: data['sourceName'] as String,
      pricePerServing: (data['pricePerServing'] ?? 0).toDouble(),
      extendedIngredients: (data['extendedIngredients'] as List<dynamic>)
          .map((e) => ExtendedIngredients.fromJson(e))
          .toList(),
      id: data['id'] as int,
      title: data['title'] as String,
      readyInMinutes: data['readyInMinutes'] as int,
      servings: data['servings'] as int,
      sourceUrl: data['sourceUrl'] as String,
      image: data['image'] as String,
      imageType: data['imageType'] as String,
      summary: data['summary'] as String,
      cuisines: data['cuisines'] as List<dynamic>,
      dishTypes: data['dishTypes'] as List<dynamic>,
      diets: data['diets'] as List<dynamic>,
      occasions: data['occasions'] as List<dynamic>,
      instructions: data['instructions'] as String,
      analyzedInstructions: (data['analyzedInstructions'] as List<dynamic>)
          .map((e) => AnalyzedInstruction.fromJson(e))
          .toList(),
      originalId: data['originalId'] as dynamic,
      spoonacularSourceUrl: data['spoonacularSourceUrl'] as String,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
