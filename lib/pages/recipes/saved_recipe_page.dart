// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_tab/recipe_tab_cubit.dart';

class RecipeTabPage extends StatefulWidget {
  @override
  _RecipeTabPageState createState() => _RecipeTabPageState();
}

class _RecipeTabPageState extends State<RecipeTabPage> {
  @override
  void initState() {
    super.initState();
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
      body: RefreshIndicator(
        color: Color.fromARGB(255, 234, 180, 225),
        onRefresh: () => _pullRefresh(),
        child: SingleChildScrollView(
          child: Container(
            height: Responsive.isSmallScreen()
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height * 0.91,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(5.5 * Responsive.ratioHorizontal),
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
                  return _buildInitialInput(state);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    await Provider.of<RecipeTabCubit>(context, listen: false)
        .fetchHomeRecipesList();
  }

  Widget _buildInitialInput(RecipeTabState state) => state is RecipeTabInitial
      ? Center(
          child: EmptyContent(
            message: 'It\'s as empty as your stomach...',
            title: 'No recipes currently saved',
            icon: Icons.hourglass_empty,
          ),
        )
      : Center(
          child: EmptyContent(
            message:
                'Please pull to refresh. If this persists please restart the application.',
            title: 'Something went wrong...',
            icon: Icons.error_outline_sharp,
          ),
        );

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 212, 147, 201),
        ),
      );

  Widget _buildColumnWithData(List<Recipe> searchResultList) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RecipeCardGrid(
            searchResultList: searchResultList,
          ),
          searchResultList.length > 10
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => this.widget),
                    ),
                    child: Icon(
                      Icons.arrow_upward_outlined,
                      color: ChowColors.black,
                    ),
                    backgroundColor: ChowColors.white,
                  ),
                )
              : SizedBox.shrink(),
          verticalDivider(factor: 12),
        ],
      ),
    );
  }
}
