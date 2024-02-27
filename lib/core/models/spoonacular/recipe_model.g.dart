// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      vegetarian: json['vegetarian'] as bool?,
      vegan: json['vegan'] as bool?,
      glutenFree: json['glutenFree'] as bool?,
      dairyFree: json['dairyFree'] as bool?,
      veryHealthy: json['veryHealthy'] as bool?,
      cheap: json['cheap'] as bool?,
      veryPopular: json['veryPopular'] as bool?,
      sustainable: json['sustainable'] as bool?,
      weightWatcherSmartPoints: json['weightWatcherSmartPoints'] as int?,
      gaps: json['gaps'] as String?,
      lowFodmap: json['lowFodmap'] as bool?,
      aggregateLikes: json['aggregateLikes'] as int?,
      spoonacularScore: (json['spoonacularScore'] as num?)?.toDouble(),
      healthScore: json['healthScore'] as int?,
      creditsText: json['creditsText'] as String?,
      license: json['license'] as String?,
      sourceName: json['sourceName'] as String?,
      pricePerServing: (json['pricePerServing'] as num?)?.toDouble(),
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) => ExtendedIngredients.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      title: json['title'] as String,
      readyInMinutes: json['readyInMinutes'] as int?,
      servings: json['servings'] as int?,
      sourceUrl: json['sourceUrl'] as String?,
      image: json['image'] as String,
      imageType: json['imageType'] as String?,
      summary: json['summary'] as String?,
      cuisines: json['cuisines'] as List<dynamic>?,
      dishTypes: json['dishTypes'] as List<dynamic>?,
      diets: json['diets'] as List<dynamic>?,
      occasions: json['occasions'] as List<dynamic>?,
      instructions: json['instructions'] as String?,
      analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>?)
          ?.map((e) => AnalyzedInstruction.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalId: json['originalId'],
      spoonacularSourceUrl: json['spoonacularSourceUrl'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'vegetarian': instance.vegetarian,
      'vegan': instance.vegan,
      'glutenFree': instance.glutenFree,
      'dairyFree': instance.dairyFree,
      'veryHealthy': instance.veryHealthy,
      'cheap': instance.cheap,
      'veryPopular': instance.veryPopular,
      'sustainable': instance.sustainable,
      'weightWatcherSmartPoints': instance.weightWatcherSmartPoints,
      'gaps': instance.gaps,
      'lowFodmap': instance.lowFodmap,
      'aggregateLikes': instance.aggregateLikes,
      'spoonacularScore': instance.spoonacularScore,
      'healthScore': instance.healthScore,
      'creditsText': instance.creditsText,
      'license': instance.license,
      'sourceName': instance.sourceName,
      'pricePerServing': instance.pricePerServing,
      'extendedIngredients': instance.extendedIngredients,
      'id': instance.id,
      'title': instance.title,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
      'sourceUrl': instance.sourceUrl,
      'image': instance.image,
      'imageType': instance.imageType,
      'summary': instance.summary,
      'cuisines': instance.cuisines,
      'dishTypes': instance.dishTypes,
      'diets': instance.diets,
      'occasions': instance.occasions,
      'instructions': instance.instructions,
      'analyzedInstructions': instance.analyzedInstructions,
      'originalId': instance.originalId,
      'spoonacularSourceUrl': instance.spoonacularSourceUrl,
    };
