// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';
import 'package:chow_down/components/design/responsive.dart';

class RecipeTabPage extends StatefulWidget {
  @override
  _RecipeTabPageState createState() => _RecipeTabPageState();
}

class _RecipeTabPageState extends State<RecipeTabPage> {
  @override
  void initState() {
    super.initState();
    // TODO: Will change this to a DB call once user can save recipes
    // Toggle this on and off to save requests
    Provider.of<RecipeTabCubit>(context, listen: false).fetchHomeRecipesList();
  }

  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

  @override
  Widget build(BuildContext context) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: 'Saved Recipes',
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(11.1),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeTabCubit, RecipeTabState>(
          listener: (context, state) {
            if (state is RecipTabError) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeTabLoading) {
              return _buildLoading();
            } else if (state is RecipeTabLoaded) {
              return _buildColumnWithData(state.recipeCardList);
            } else {
              // error state snackbar
              return _buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput() => Padding(
        padding: EdgeInsets.only(top: 12 * Responsive.ratioVertical),
        child: Column(
          // Home page here
          children: [Container()],
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 212, 147, 201),
        ),
      );

  Widget _buildColumnWithData(RecipeCardInfoList searchResultList) =>
      RecipeCardGrid(
        searchResultList: searchResultList,
      );

  Widget _buildColumnWithData2(RecipeCardInfoList searchResultList) {
    searchResultList == null
        ? RecipeCardGrid(
            searchResultList: searchResultList,
          )
        : EmptyContent(
            message: 'No recipes saved',
            title: 'A whole lotta Nothing',
          );
  }
}
