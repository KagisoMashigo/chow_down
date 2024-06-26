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

class RecipeDescriptionCard extends StatelessWidget {
  const RecipeDescriptionCard({
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
    return BaseCard(
      child: Padding(
        padding: EdgeInsets.all(
          Spacing.sm,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: Spacing.xsm),
                _buildDetailCard(
                  title: 'Ready In:',
                  subtitle: '${StringHelper.cookTimeConverter(readyInMinutes)}',
                ),
                _buildDetailCard(
                  title: 'Servings:',
                  subtitle: '${servings.toString()}',
                ),
                SizedBox(width: Spacing.xsm),
              ],
            ),
            if (veryHealthy) ...[
              SizedBox(height: Spacing.sm),
              Row(
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
            ],
            SizedBox(height: Spacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
              child: Text(
                'By $creditsText',
                style: TextStyle(
                  fontSize: ChowFontSizes.smd,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(height: Spacing.xsm),
            TextButton(
              onPressed: _launchUrl,
              child: Text('Source: $sourceUrl'),
            ),
            SizedBox(height: Spacing.xsm),
            ..._buildIngredients(ingredients!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required String subtitle,
  }) {
    return DetailCard(
      child: Column(
        children: [
          Text(title),
          SizedBox(height: Spacing.xsm),
          Text(
            subtitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      color: ChowColors.black,
    );
  }

  // TODO: strip brackets from ingredients
  List<Widget> _buildIngredients(List<ExtendedIngredients> ingredients) {
    return ingredients
        .map((ingredient) => ListTile(
              title: Text(
                '${StringHelper.processNumber(ingredient.amount.toString())} ${ingredient.unit == 'servings' ? '' : ingredient.unit} ${ingredient.name}',
                style: TextStyle(
                  fontSize: 4 * Responsive.ratioHorizontal,
                ),
              ),
              leading: Icon(Icons.food_bank_sharp),
            ))
        .toList();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(sourceUrl))) {
      throw 'Could not launch ${Uri.parse(sourceUrl)}';
    }
  }
}
