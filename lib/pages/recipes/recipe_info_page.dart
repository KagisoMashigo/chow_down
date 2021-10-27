// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/plugins/responsive.dart';

class RecipeInfoPage extends StatefulWidget {
  const RecipeInfoPage({
    Key key,
    @required this.recipeId,
  }) : super(key: key);

  /// Device source
  final String recipeId;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.recipeId),
    );
  }
}
