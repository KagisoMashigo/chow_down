// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';

class RecipeCardGrid extends StatelessWidget {
  const RecipeCardGrid({
    Key key,
    @required this.searchResultList,
  }) : super(key: key);

  final List<Object> searchResultList;

  @override
  Widget build(BuildContext context) {
    final results = searchResultList;

    return GridView.count(
      primary: false,
      padding: EdgeInsets.symmetric(
        vertical: 2 * Responsive.ratioVertical,
        horizontal: 2 * Responsive.ratioHorizontal,
      ),
      crossAxisCount: 2,
      childAspectRatio: 0.4 * Responsive.ratioSquare,
      mainAxisSpacing: 4 * Responsive.ratioVertical,
      crossAxisSpacing: 5.5 * Responsive.ratioHorizontal,
      children: _getStructuredCardGrid(results, context),
      shrinkWrap: true,
    );
  }

  List<Container> _getStructuredCardGrid(List<Recipe> results, context) {
    print(results);
    return results.map((recipe) {
      return Container(
        child: Card(
          child: Column(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecipeInfoPage(
                        title: recipe.title,
                        id: recipe.id,
                      ),
                      fullscreenDialog: true,
                    ));
                  },
                  child: Image.network(
                    recipe.image,
                    width: 18.5 * Responsive.ratioVertical,
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: EdgeInsets.all(2 * Responsive.ratioHorizontal),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 3.25 * Responsive.ratioHorizontal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
