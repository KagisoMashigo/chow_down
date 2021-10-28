// 🐦 Flutter imports:
import 'package:chow_down/components/customAppBar.dart';
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
  Widget build(BuildContext conxtext) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: 'recipe name',
      body: ListView(
        children: [
          verticalDivider(factor: 2),
          Center(
            child: Text(widget.recipeId),
          ),
        ],
      ),
    );
  }
}
