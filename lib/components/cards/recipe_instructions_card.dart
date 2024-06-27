// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/base_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/analysed_instructions.dart';

class RecipeInstructionsCard extends StatelessWidget {
  const RecipeInstructionsCard({
    Key? key,
    this.analyzedInstructions,
    required this.instructions,
  }) : super(key: key);

  final List<AnalyzedInstruction>? analyzedInstructions;

  final String instructions;

  @override
  Widget build(BuildContext context) {
    final actualSteps = analyzedInstructions?[0].steps;

    return actualSteps != null
        ? BaseCard(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Spacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: actualSteps
                        .map((instruction) => ListTile(
                              title: Text(
                                instruction.step,
                                style: TextStyle(
                                  fontSize: ChowFontSizes.sm,
                                ),
                              ),
                              leading: Text(
                                instruction.number.toString(),
                                style: TextStyle(
                                  fontSize: ChowFontSizes.sm,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          )
        : EmptyContent(
            title: 'Instructions failed to load',
            message:
                'There was an issue loading the instructions for this recipe. Please try again.',
          );
  }
}
