// 🐦 Flutter imports:
import 'package:chow_down/components/design/color.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';

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
      color: ChowColors.white,
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
        padding: EdgeInsets.all(5.5 * Responsive.ratioHorizontal),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeTabCubit, RecipeTabState>(
          listener: (context, state) {
            print('${state} UI state');

            if (state is RecipTabError) {
              print('${state.message} UI error');
              // return Text('${state.message}');
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeTabLoading) {
              print('${state} UI error laoding');

              return _buildLoading();
            } else if (state is RecipeTabLoaded) {
              print('${state} UI error loaded');

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
          children: [
            Center(
              child: Text('EMPTY'),
            )
          ],
        ),
      );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 212, 147, 201),
        ),
      );

  Widget _buildColumnWithData(RecipeCardInfoList searchResultList) =>
      SingleChildScrollView(
        child: Column(
          children: [
            RecipeCardGrid(
              searchResultList: searchResultList,
            ),
            verticalDivider(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => this.widget)),
                child: Icon(
                  Icons.arrow_upward_outlined,
                  color: ChowColors.black,
                ),
                backgroundColor: ChowColors.white,
              ),
            ),
            verticalDivider(factor: 11),
          ],
        ),
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
