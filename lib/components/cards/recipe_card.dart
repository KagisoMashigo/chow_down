// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.url,
    this.imageType,
    @required this.readyInMinutes,
    @required this.vegetarian,
    @required this.vegan,
    @required this.servings,
    @required this.glutenFree,
    this.extendedIngredients,
    this.analyzedInstructions,
    @required this.loadingColor,
  }) : super(key: key);

  /// Recipe id
  final int id;

  /// Recipe name
  final String name;

  /// Recipe url
  final String imageUrl;

  final String url;

  final String imageType;

  final int readyInMinutes;

  final bool vegetarian;

  final bool vegan;

  final bool glutenFree;

  final Color loadingColor;

  final int servings;

  final List<ExtendedIngredients> extendedIngredients;

  final List<AnalyzedInstruction> analyzedInstructions;

  String _isVegetarian(bool veg) => veg ? 'Vegetarian' : 'Omnivore';

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  name.toString(),
                  style: TextStyle(
                    fontSize: 4 * Responsive.ratioHorizontal,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          verticalDivider(factor: 1.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                      height: 55,
                      width: 5,
                      child: SpinKitThreeBounce(
                        color: loadingColor,
                        size: 20.0,
                      ),
                    ),
                    imageUrl: imageUrl,
                    width: 35 * Responsive.ratioHorizontal,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalDivider(factor: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined),
                      horizontalDivider(),
                      Text(
                        cookTimeConverter(readyInMinutes),
                        style: TextStyle(
                          fontSize: 3.75 * Responsive.ratioHorizontal,
                        ),
                      ),
                    ],
                  ),
                  verticalDivider(factor: 1.5),
                  Row(
                    children: [
                      Icon(Icons.soup_kitchen),
                      horizontalDivider(),
                      Text(
                        '${servings.toString()} servings',
                        style: TextStyle(
                          fontSize: 3.75 * Responsive.ratioHorizontal,
                        ),
                      ),
                    ],
                  ),
                  verticalDivider(factor: 1.5),
                  Row(
                    children: [
                      Icon(Icons.food_bank_outlined),
                      horizontalDivider(),
                      Text(
                        '${vegan ? 'Vegan' : _isVegetarian(vegetarian)}',
                        style: TextStyle(
                          fontSize: 3.75 * Responsive.ratioHorizontal,
                        ),
                      ),
                    ],
                  ),
                  verticalDivider(factor: 1.5),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
