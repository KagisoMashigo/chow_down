import 'package:chow_down/components/cards/recipe_card_grid.dart';
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/recipe_home.dart/recipe_home_cubit.dart';
import 'package:chow_down/cubit/search/search_cubit.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  @override
  void initState() {
    super.initState();
    // Will change this to a DB call once user can save recipes
    Provider.of<RecipeHomeCubit>(context, listen: false).fetchHomeRecipesList();
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
        child: BlocConsumer<RecipeHomeCubit, RecipeHomeState>(
          listener: (context, state) {
            if (state is RecipeHomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeHomeLoading) {
              return _buildLoading();
            } else if (state is RecipeHomeLoaded) {
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
          children: [SearchInputField()],
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

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        style: TextStyle(color: Colors.white),
        onSubmitted: (query) => _submitForm(context, query),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: "Search a recipe",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(Icons.search),
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _submitForm(BuildContext context, String query) {
    final searchCubit = context.read<SearchCubit>();
    searchCubit.fetchSearchResults(query);
  }
}
