class Recipe {
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final bool veryHealthy;
  final bool cheap;
  final bool veryPopular;
  final bool sustainable;
  final int weightWatcherSmartPoints;
  final String gaps;
  final bool lowFodmap;
  final int aggregateLikes;
  final double spoonacularScore;
  final double healthScore;
  final String creditsText;
  final String license;
  final String sourceName;
  final double pricePerServing;
  final int id;
  final String title;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final String image;
  final String imageType;
  final String summary;
  final List cuisines;
  final List dishTypes;
  final List diets;
  final List occasions;
  final String analyzedInstructions;
  final String spoonacularSourceUrl;

  Recipe(
      {this.vegetarian,
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
      this.analyzedInstructions,
      this.spoonacularSourceUrl});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      vegetarian: json['vegetarian'],
      vegan: json['vegan'],
      glutenFree: json['glutenFree'],
      dairyFree: json['dairyFree'],
      veryHealthy: json['veryHealthy'],
      cheap: json['cheap'],
      veryPopular: json['veryPopular'],
      sustainable: json['sustainable'],
      weightWatcherSmartPoints: json['weightWatcherSmartPoints'],
      gaps: json['gaps'],
      lowFodmap: json['lowFodmap'],
      aggregateLikes: json['aggregateLikes'],
      spoonacularScore: json['spoonacularScore'],
      healthScore: json['healthScore'],
      creditsText: json['creditsText'],
      license: json['license'],
      sourceName: json['sourceName'],
      pricePerServing: json['pricePerServing'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      id: json['id'],
      title: json['title'],
      image: json['image'],
      imageType: json['imageType'],
      summary: json['summary'],
      cuisines: json['cuisines'],
      dishTypes: json['dishTypes'],
      diets: json['diets'],
      occasions: json['occasions'],
      analyzedInstructions: json['analyzedInstructions'],
      spoonacularSourceUrl: json['spoonacularSourceUrl'],
    );
  }
}
