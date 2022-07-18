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
    final actualSteps = analyzedInstructions[0].steps;

    return BaseCard(
      child: Column(
        children: [
          // verticalDivider(factor: 2.5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: actualSteps
                  .map((e) => ListTile(
                        title: Text(
                          e.step,
                          style: TextStyle(
                            fontSize: 4 * Responsive.ratioHorizontal,
                          ),
                        ),
                        leading: Text(
                          e.number.toString(),
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

  Text showSteps(List list) {
    var counter = 0;
    for (var i = 1; i <= list.length; i++) {
      print(i);
      counter++;
      return Text(counter.toString());
    }
    // return;
  }
}
