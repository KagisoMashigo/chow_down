// 📦 Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';

class Recipe {
  bool vegetarian;
  bool vegan;
  bool glutenFree;
  bool dairyFree;
  bool veryHealthy;
  bool cheap;
  bool veryPopular;
  bool sustainable;
  int weightWatcherSmartPoints;
  String gaps;
  bool lowFodmap;
  int aggregateLikes;
  double spoonacularScore;
  int healthScore;
  String creditsText;
  String license;
  String sourceName;
  double pricePerServing;
  List<ExtendedIngredients> extendedIngredients;
  int id;
  String title;
  int readyInMinutes;
  int servings;
  String sourceUrl;
  String image;
  String imageType;
  String summary;
  List<dynamic> cuisines;
  List<dynamic> dishTypes;
  List<dynamic> diets;
  List<dynamic> occasions;
  String instructions;
  List<AnalyzedInstruction> analyzedInstructions;
  dynamic originalId;
  String spoonacularSourceUrl;

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
    this.instructions,
    this.analyzedInstructions,
    this.originalId,
    this.spoonacularSourceUrl,
  });

  factory Recipe.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    // SnapshotOptions options,
  ) {
    final data = snapshot.data();
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
      extendedIngredients: (data['extendedIngredients'] as List<dynamic> ?? [])
              .map((e) => ExtendedIngredients.fromJson(e))
              .toList() ??
          [],
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
      analyzedInstructions:
          (data['analyzedInstructions'] as List<dynamic> ?? [])
              .map((e) => AnalyzedInstruction.fromJson(e))
              .toList(),
      originalId: data['originalId'] as dynamic,
      spoonacularSourceUrl: data['spoonacularSourceUrl'] as String,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        vegetarian: json['vegetarian'] as bool,
        vegan: json['vegan'] as bool,
        glutenFree: json['glutenFree'] as bool,
        dairyFree: json['dairyFree'] as bool,
        veryHealthy: json['veryHealthy'] as bool,
        cheap: json['cheap'] as bool,
        veryPopular: json['veryPopular'] as bool,
        sustainable: json['sustainable'] as bool,
        weightWatcherSmartPoints: json['weightWatcherSmartPoints'] as int,
        gaps: json['gaps'] as String,
        lowFodmap: json['lowFodmap'] as bool,
        aggregateLikes: json['aggregateLikes'] as int,
        spoonacularScore: json['spoonacularScore'] as double,
        healthScore: json['healthScore'] as int,
        creditsText: json['creditsText'] as String,
        license: json['license'] as String,
        sourceName: json['sourceName'] as String,
        pricePerServing: (json['pricePerServing'] ?? 0),
        extendedIngredients:
            (json['extendedIngredients'] as List<dynamic> ?? [])
                    .map((e) => ExtendedIngredients.fromJson(e))
                    .toList() ??
                [],
        id: json['id'] as int,
        title: json['title'] as String,
        readyInMinutes: json['readyInMinutes'] as int,
        servings: json['servings'] as int,
        sourceUrl: json['sourceUrl'] as String,
        image: json['image'] as String,
        imageType: json['imageType'] as String,
        summary: json['summary'] as String,
        cuisines: json['cuisines'] as List<dynamic>,
        dishTypes: json['dishTypes'] as List<dynamic>,
        diets: json['diets'] as List<dynamic>,
        occasions: json['occasions'] as List<dynamic>,
        instructions: json['instructions'] as String,
        analyzedInstructions:
            (json['analyzedInstructions'] as List<dynamic> ?? [])
                .map((e) => AnalyzedInstruction.fromJson(e))
                .toList(),
        originalId: json['originalId'] as dynamic,
        spoonacularSourceUrl: json['spoonacularSourceUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'vegetarian': vegetarian,
        'vegan': vegan,
        'glutenFree': glutenFree,
        'dairyFree': dairyFree,
        'veryHealthy': veryHealthy,
        'cheap': cheap,
        'veryPopular': veryPopular,
        'sustainable': sustainable,
        'weightWatcherSmartPoints': weightWatcherSmartPoints,
        'gaps': gaps,
        'lowFodmap': lowFodmap,
        'aggregateLikes': aggregateLikes,
        'spoonacularScore': spoonacularScore,
        'healthScore': healthScore,
        'creditsText': creditsText,
        'license': license,
        'sourceName': sourceName,
        'pricePerServing': pricePerServing,
        'extendedIngredients': extendedIngredients
                ?.map((e) => e != null ? e?.toJson() : null)
                ?.toList() ??
            [],
        'readyInMinutes': readyInMinutes,
        'servings': servings,
        'sourceUrl': sourceUrl,
        'image': image,
        'imageType': imageType,
        'summary': summary,
        'cuisines': cuisines,
        'dishTypes': dishTypes,
        'diets': diets,
        'occasions': occasions,
        'instructions': instructions,
        'analyzedInstructions': analyzedInstructions
                ?.map((e) => e != null ? e?.toJson() : null)
                ?.toList() ??
            [],
        'originalId': originalId,
        'spoonacularSourceUrl': spoonacularSourceUrl,
      };
}
