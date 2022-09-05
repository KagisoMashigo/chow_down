// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';

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
    final actualSteps = analyzedInstructions[0].steps;

    return BaseCard(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(4 * Responsive.ratioHorizontal),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: actualSteps
                  .map((instruction) => ListTile(
                        title: Text(
                          instruction.step,
                          style: TextStyle(
                            fontSize: 4 * Responsive.ratioHorizontal,
                          ),
                        ),
                        leading: Text(
                          instruction.number.toString(),
                          style: TextStyle(
                            fontSize: 4 * Responsive.ratioHorizontal,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          verticalDivider(factor: 2.5),
        ],
      ),
    );
  }
}
