import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RecipeTabPage extends StatefulWidget {
  @override
  _RecipeTabPageState createState() => _RecipeTabPageState();
}

class _RecipeTabPageState extends State<RecipeTabPage> {
  @override
  void initState() {
    super.initState();
    // Will change this to a DB call once user can save recipes
    // Toggle this on and off to save requests
    Provider.of<RecipeTabCubit>(context, listen: false).fetchHomeRecipesList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: 'Saved Recipes',
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1528458876861-544fd1761a91?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1388&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(11.1),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeTabCubit, RecipeTabState>(
          listener: (context, state) {
            if (state is RecipTabError) {
              ScaffoldMessenger.of(context).showSnackBar(
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
          children: [Container()],
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildColumnWithData(RecipeCardInfoList searchResultList) =>
      RecipeCardGrid(
        searchResultList: searchResultList,
      );
}
