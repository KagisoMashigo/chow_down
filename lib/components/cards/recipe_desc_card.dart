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

  // String exactTime(int cookTime){
  //   if (cookTime > 59) {
  //     return
  //   }
  // }

  String cookTimeConverter(int cookTime) {
    var duration = Duration(minutes: cookTime);
    List<String> timeParts = duration.toString().split(':');
    var hours =
        '${timeParts[0].padLeft(2, '')} hours ${timeParts[1].padLeft(2, '0')} minutes';
    var minutes = '${timeParts[1].padLeft(2, '0')} minutes';

    if (cookTime > 59) {
      return hours;
    }

    return minutes;
  }
}
