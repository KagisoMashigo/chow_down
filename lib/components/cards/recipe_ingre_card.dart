// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/plugins/utils/helpers.dart';

class RecipeDescCard extends StatelessWidget {
  const RecipeDescCard({
    Key? key,
    required this.readyInMinutes,
    required this.servings,
    required this.creditsText,
    required this.glutenFree,
    required this.vegetarian,
    this.summary,
    required this.ingredients,
    required this.sourceUrl,
    required this.veryHealthy,
  }) : super(key: key);

  final int readyInMinutes;

  final int servings;

  final String creditsText;

  final bool glutenFree;

  final bool veryHealthy;

  final bool vegetarian;

  final String? summary;

  final String sourceUrl;

  final List<ExtendedIngredients>? ingredients;

  @override
  Widget build(BuildContext context) {
    /// This replaces all floating 0s
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)', unicode: true);

    return BaseCard(
      child: Column(
        children: [
          verticalDivider(factor: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              verticalDivider(factor: 4),
              DetailCard(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.ratioHorizontal),
                      child: Text('Ready In: '),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.ratioHorizontal),
                      child: Text(
                        '${cookTimeConverter(readyInMinutes)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                color: ChowColors.black,
              ),
              DetailCard(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.ratioHorizontal),
                      child: Text('Servings:'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.ratioHorizontal),
                      child: Text(
                        '${servings.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                color: ChowColors.black,
              ),
              verticalDivider(factor: 4),
            ],
          ),
          verticalDivider(factor: 4),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4 * Responsive.ratioHorizontal),
            child: Column(
              children: [
                veryHealthy
                    ? Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 25,
                          ),
                          Expanded(
                            child: Text(
                              'Very Healthy!',
                              style: TextStyle(
                                fontSize: 4 * Responsive.ratioHorizontal,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                verticalDivider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By ${creditsText ?? 'Anonymous'}',
                        style: TextStyle(
                          fontSize: 4 * Responsive.ratioHorizontal,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalDivider(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _launchUrl,
                        child: Text('Source: ${sourceUrl ?? 'Unknown'}'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalDivider(factor: 2.5),
          Center(
            child: Column(
              children: ingredients!
                  .map((ingredient) => ListTile(
                        title: Text(
                          '${ingredient.amount.toString().replaceAll(regex, '')} ${ingredient.unit == 'servings' ? '' : ingredient.unit} ${ingredient.name}',
                          style: TextStyle(
                            fontSize: 4 * Responsive.ratioHorizontal,
                          ),
                        ),
                        leading: Icon(Icons.food_bank_sharp),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(sourceUrl))) {
      throw 'Could not launch ${Uri.parse(sourceUrl)}';
    }
  }
}
