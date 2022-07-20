import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/extended_ingredients.dart';
import 'package:chow_down/plugins/helpers.dart';
import 'package:flutter/material.dart';

class RecipeDescCard extends StatelessWidget {
  const RecipeDescCard({
    Key key,
    @required this.readyInMinutes,
    @required this.servings,
    @required this.creditsText,
    @required this.glutenFree,
    @required this.vegetarian,
    @required this.summary,
    @required this.ingredients,
    @required this.sourceUrl,
  }) : super(key: key);

  final int readyInMinutes;

  final int servings;

  final String creditsText;

  final bool glutenFree;

  final bool vegetarian;

  final String summary;

  final String sourceUrl;

  final List<ExtendedIngredients> ingredients;

  @override
  Widget build(BuildContext context) {
    /// This replaces all floating 0s
    RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

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
                      child: Text(
                        'Source: ${sourceUrl ?? 'Unknown'}',
                        style: TextStyle(
                          fontSize: 4 * Responsive.ratioHorizontal,
                          // fontStyle: FontStyle.italic,
                        ),
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
              children: ingredients
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
}
