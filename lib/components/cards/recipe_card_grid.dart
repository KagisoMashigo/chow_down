import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';

class RecipeCardGrid extends StatelessWidget {
  const RecipeCardGrid({
    Key key,
    @required this.searchResultList,
  }) : super(key: key);

  final RecipeCardInfoList searchResultList;

  @override
  Widget build(BuildContext context) {
    final results = searchResultList.list;

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2.1),
      crossAxisCount: 2,
      childAspectRatio: 0.90,
      mainAxisSpacing: 30.0,
      crossAxisSpacing: 10.0,
      children: _getStructuredCardGrid(results, context),
      shrinkWrap: true,
    );
  }

  List<Container> _getStructuredCardGrid(
      List<RecipeCardInfo> results, context) {
    return results.map((recipe) {
      return Container(
        child: Card(
            child: Column(
          children: <Widget>[
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RecipeInfoPage(recipeId: recipe.id.toString()),
                      fullscreenDialog: true,
                    ));
                    // Widget snackBar =
                    //     SnackBar(content: Text(recipe.id.toString()));

                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Image.network(
                    recipe.image,
                    width: 20 * Responsive.ratioVertical,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                verticalDivider(factor: 1),
                Text(recipe.name),
                verticalDivider(factor: 1),
                Text('Rating'),
              ],
            )
          ],
        )),
      );
    }).toList();
  }
}
