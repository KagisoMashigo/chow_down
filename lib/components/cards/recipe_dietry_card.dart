// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';

class RecipeDietaryCard extends StatelessWidget {
  const RecipeDietaryCard({
    Key? key,
    required this.glutenFree,
    required this.vegetarian,
    required this.dairyFree,
    this.veryHealthy,
    required this.vegan,
    required this.healthScore,
  }) : super(key: key);

  final bool glutenFree;

  final int healthScore;

  final bool vegan;

  final bool vegetarian;

  final bool dairyFree;

  final bool? veryHealthy;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailCard(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.xsm,
                            ),
                            child: Text('Gluten Free:'),
                          ),
                          if (glutenFree)
                            Icon(
                              Icons.check,
                              color: ChowColors.green700,
                            )
                          else if (!glutenFree)
                            Icon(
                              Icons.close,
                              color: ChowColors.red,
                            )
                          else
                            Icon(
                              Icons.question_mark,
                              color: ChowColors.black,
                              size: 20,
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
                              horizontal: Spacing.xsm,
                            ),
                            child: Text('Dairy Free:'),
                          ),
                          if (dairyFree)
                            Icon(
                              Icons.check,
                              color: ChowColors.green700,
                            )
                          else if (!dairyFree)
                            Icon(
                              Icons.close,
                              color: ChowColors.red,
                            )
                          else
                            Icon(
                              Icons.question_mark,
                              color: ChowColors.black,
                              size: 20,
                            ),
                        ],
                      ),
                      color: ChowColors.black,
                    ),
                  ],
                ),
                SizedBox(height: Spacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DetailCard(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Spacing.xsm,
                            ),
                            child: Text('Vegetarian:'),
                          ),
                          if (vegetarian)
                            Icon(
                              Icons.check,
                              color: ChowColors.green700,
                            )
                          else if (!vegetarian)
                            Icon(
                              Icons.close,
                              color: ChowColors.red,
                            )
                          else
                            Icon(
                              Icons.question_mark,
                              color: ChowColors.black,
                              size: 20,
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
                              horizontal: Spacing.xsm,
                            ),
                            child: Text('Vegan:'),
                          ),
                          if (vegan)
                            Icon(
                              Icons.check,
                              color: ChowColors.green700,
                            )
                          else if (!vegan)
                            Icon(
                              Icons.close,
                              color: ChowColors.red,
                            )
                          else
                            Icon(
                              Icons.question_mark,
                              color: ChowColors.black,
                              size: 20,
                            ),
                        ],
                      ),
                      color: ChowColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
