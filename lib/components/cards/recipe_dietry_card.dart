// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/design/responsive.dart';

class RecipeDietCard extends StatelessWidget {
  const RecipeDietCard({
    Key key,
    @required this.glutenFree,
    @required this.vegetarian,
    this.dairyFree,
    this.veryHealthy,
    this.vegan,
    this.healthScore,
  }) : super(key: key);

  final bool glutenFree;

  final int healthScore;

  final bool vegan;

  final bool vegetarian;

  final bool dairyFree;

  final bool veryHealthy;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailCard(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3 * Responsive.ratioHorizontal),
                        child: Text('Gluten Free:'),
                      ),
                      Icon(
                        glutenFree ? Icons.check : Icons.close,
                        color:
                            glutenFree ? ChowColors.green700 : ChowColors.red,
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
                        child: Text('Dairy Free:'),
                      ),
                      Icon(
                        dairyFree ? Icons.check : Icons.close,
                        color: dairyFree ? ChowColors.green700 : ChowColors.red,
                      ),
                    ],
                  ),
                  color: ChowColors.black,
                ),
              ],
            ),
            verticalDivider(factor: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailCard(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3 * Responsive.ratioHorizontal),
                        child: Text('Vegetarian:'),
                      ),
                      Icon(
                        vegetarian ? Icons.check : Icons.close,
                        color:
                            vegetarian ? ChowColors.green700 : ChowColors.red,
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
                        child: Text('Vegan:'),
                      ),
                      Icon(
                        vegan ? Icons.check : Icons.close,
                        color: vegan ? ChowColors.green700 : ChowColors.red,
                      ),
                    ],
                  ),
                  color: ChowColors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
