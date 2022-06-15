import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:flutter/material.dart';

class RecipeDietCard extends StatelessWidget {
  const RecipeDietCard({
    Key key,
    @required this.glutenFree,
    @required this.vegetarian,
  }) : super(key: key);

  final bool glutenFree;

  final bool vegetarian;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        children: [
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
        ],
      ),
    );
  }
}
