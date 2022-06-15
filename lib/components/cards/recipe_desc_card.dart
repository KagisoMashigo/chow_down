import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';
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
  }) : super(key: key);

  final int readyInMinutes;

  final int servings;

  final String creditsText;

  final bool glutenFree;

  final bool vegetarian;

  final String summary;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DetailCard(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * Responsive.ratioHorizontal),
                      child: Text(
                          'Ready In: ${readyInMinutes.toString()} minutes'),
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
          verticalDivider(factor: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  'By ${creditsText}',
                  style: TextStyle(
                    fontSize: 4 * Responsive.ratioHorizontal,
                    fontStyle: FontStyle.italic,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          verticalDivider(factor: 2.5),
          Center(
            child: Text(
              summary
                  .replaceAll('</b>', '')
                  .replaceAll('<b>', '')
                  .replaceAll('<a href=', '')
                  .replaceAll('</a>', '')
                  .replaceAll('>', '')
                  .replaceAll('"', ''),
              style: TextStyle(
                fontSize: 4 * Responsive.ratioHorizontal,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
