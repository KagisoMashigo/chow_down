import 'package:chow_down/components/cards/base_card.dart';
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
              Text(
                'Ready In: ${readyInMinutes.toString()} minutes',
                style: TextStyle(
                  fontSize: 4 * Responsive.ratioHorizontal,
                  // fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                'Servings: ${servings.toString()}',
                style: TextStyle(
                  fontSize: 4 * Responsive.ratioHorizontal,
                  // fontStyle: FontStyle.italic,
                ),
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
          // Column(children: _whichConditions(_currentIndex, mockData)
          // .map<Widget>(
          //   (condition) => CurrentConditionsCards(
          //     availableCapacity: condition['availableCapacity'],
          //     uid: condition['uid'],
          //     sailingUid: condition['sailingUid'],
          //     departureTime: condition['departureTime'],
          //     depStatus: condition['depStatus'],
          //     status: condition['status'],
          //     imgUrl: condition['imgUrl'],
          //   ),
          // )
          // .toList(),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TODO create rating system
              // const Icon(Icons.stars),
              // horizontalDivider(factor: 2),
              // Text(
              //   '564 ratings',
              //   style: TextStyle(
              //     fontSize: 5 * Responsive.ratioHorizontal,
              //     // fontStyle: FontStyle.italic,
              //   ),
              // ),
              // horizontalDivider(factor: 2),
              // TextButton(
              //   onPressed: () => print('rated!'),
              //   child: Text(
              //     'rate this recipe',
              //     style: TextStyle(
              //       fontSize: 5 * Responsive.ratioHorizontal,
              //       // fontStyle: FontStyle.italic,
              //     ),
              //   ),
              // ),
            ],
          ),
          verticalDivider(factor: 2.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
              // horizontalDivider(factor: 4),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gluten Free: ${glutenFree.toString()}',
                      style: TextStyle(
                        fontSize: 4 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    verticalDivider(factor: 4),
                    Text(
                      'Vegetarian: ${vegetarian.toString()}',
                      style: TextStyle(
                        fontSize: 4 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
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
