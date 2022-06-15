import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';
import 'package:flutter/material.dart';

class RecipeInstCard extends StatelessWidget {
  const RecipeInstCard({
    Key key,
    this.analyzedInstructions,
    @required this.instructions,
  }) : super(key: key);

  final List<AnalyzedInstruction> analyzedInstructions;

  final String instructions;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      child: Column(
        children: [
          verticalDivider(factor: 2.5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    instructions.replaceAll('.', '. '),
                    style: TextStyle(
                      fontSize: 4 * Responsive.ratioHorizontal,
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                verticalDivider(factor: 4),
              ],
            ),
          ),
          verticalDivider(factor: 2.5),
        ],
      ),
    );
  }
}
