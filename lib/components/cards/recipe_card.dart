// 🐦 Flutter imports:
import 'package:chow_down/plugins/utils/constants.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
    required this.id,
    required this.name,
    this.imageUrl,
    required this.url,
    this.imageType,
    required this.readyInMinutes,
    required this.vegetarian,
    required this.vegan,
    required this.servings,
    required this.glutenFree,
    this.extendedIngredients,
    this.analyzedInstructions,
    required this.loadingColor,
  }) : super(key: key);

  final int id;

  final String name;

  final String? imageUrl;

  final String url;

  final String? imageType;

  final int readyInMinutes;

  final bool vegetarian;

  final bool vegan;

  final bool glutenFree;

  final Color loadingColor;

  final int servings;

  final List<ExtendedIngredients>? extendedIngredients;

  final List<AnalyzedInstruction>? analyzedInstructions;

  String _isVegetarian(bool veg) => veg ? 'Vegetarian' : 'Omnivore';

  @override
  Widget build(BuildContext context) {
    final image = imageUrl != null
        ? CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
              height: 55,
              child: SpinKitThreeBounce(
                color: loadingColor,
                size: 20.0,
              ),
            ),
            imageUrl: imageUrl!,
            fit: BoxFit.cover,
          )
        : Image.asset(
            NO_IMAGE_AVAILABLE,
            fit: BoxFit.cover,
          );

    return BaseCard(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xsm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toString(),
              style: TextStyle(
                fontSize: ChowFontSizes.smd,
                color: Colors.black,
              ),
            ),
            SizedBox(height: Spacing.xsm),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: image,
                    ),
                  ),
                ),
                SizedBox(width: Spacing.sm),
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer_outlined),
                          SizedBox(width: Spacing.xsm),
                          Text(
                            StringHelper.cookTimeConverter(readyInMinutes),
                            style: TextStyle(
                              fontSize: ChowFontSizes.sm,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.xsm),
                      Row(
                        children: [
                          Icon(Icons.soup_kitchen),
                          SizedBox(width: Spacing.xsm),
                          Text(
                            '${servings.toString()} servings',
                            style: TextStyle(
                              fontSize: ChowFontSizes.sm,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.xsm),
                      Row(
                        children: [
                          Icon(Icons.food_bank_outlined),
                          SizedBox(width: Spacing.xsm),
                          Text(
                            '${vegan ? 'Vegan' : _isVegetarian(vegetarian)}',
                            style: TextStyle(
                              fontSize: ChowFontSizes.sm,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Spacing.xsm),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
