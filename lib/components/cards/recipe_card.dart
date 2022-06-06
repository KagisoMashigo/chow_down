// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/responsive.dart';

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
    @required this.servings,
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

  final int servings;

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
                    // fontWeight: FontWeight.bold,
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
                elevation: 2,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl,
                    width: 35 * Responsive.ratioHorizontal,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalDivider(factor: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.coffee_maker_outlined),
                      horizontalDivider(),
                      Text(
                        '${readyInMinutes.toString()} mins',
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
                        '${vegetarian ? 'Vegetarian' : 'Omnivores'}',
                        style: TextStyle(
                          fontSize: 3.75 * Responsive.ratioHorizontal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
