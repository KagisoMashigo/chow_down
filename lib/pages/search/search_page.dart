// 🐦 Flutter imports:
// 🌎 Project imports:
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/search/search_cubit.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:flutter/material.dart';
// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1559703248-dcaaec9fab78?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        // padding: EdgeInsets.only(top: 2.5 * Responsive.ratioVertical),
        alignment: Alignment.center,
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              return _buildInitialInput();
            } else if (state is SearchLoading) {
              return _buildLoading();
            } else if (state is SearchLoaded) {
              return _buildColumnWithData(state.searchResultList);
            } else {
              // error state snackbar
              return _buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialInput() {
    return Padding(
      padding: EdgeInsets.only(top: 12 * Responsive.ratioVertical),
      child: Column(
        children: [SearchInputField()],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildColumnWithData(RecipeCardInfoList searchResultList) {
    final recipes = searchResultList.list;
    final mappedRecipes = recipes.asMap().entries;

    return SingleChildScrollView(
      child: Column(
        children: [
          // verticalDivider(factor: 7),
          SearchInputField(),
          Padding(
            padding: EdgeInsets.all(8 * Responsive.ratioHorizontal),
            child: Row(
              children: [
                Text(
                  'Results: ${recipes.length}',
                  style: TextStyle(
                    fontSize: 4 * Responsive.ratioHorizontal,
                    color: ChowColors.white,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5 * Responsive.ratioHorizontal),
                child: Column(
                  children: mappedRecipes.map((recipe) {
                    // This is the index to be used to iterate
                    int index = recipe.key;

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeInfoPage(
                            title: recipes[index].title,
                            id: recipes[index].id,
                            sourceUrl: recipes[index].sourceUrl,
                          ),
                        ),
                      ),
                      child: RecipeCard(
                        id: recipes[index].id,
                        name: recipes[index].title,
                        imageUrl: recipes[index].image,
                        url: recipes[index].sourceUrl,
                        glutenFree: recipes[index].glutenFree,
                        readyInMinutes: recipes[index].readyInMinutes,
                        vegetarian: recipes[index].vegetarian,
                        vegan: recipes[index].vegan,
                        servings: recipes[index].servings,
                      ),
                    );
                  }).toList(),
                ),
              ),
              recipes.length < 4
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: FloatingActionButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    this.widget)),
                        child: Icon(
                          Icons.arrow_upward_outlined,
                          color: ChowColors.black,
                        ),
                        backgroundColor: ChowColors.white,
                      ),
                    ),
              verticalDivider(factor: 12)
            ],
          ),
        ],
      ),
    );
  }
}

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 * Responsive.ratioHorizontal),
      child: TextField(
        style: TextStyle(color: ChowColors.white),
        onSubmitted: (query) => _submitForm(context, query),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            hintText: "Search for a recipe",
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ChowColors.white, width: 0.0),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(Icons.search),
            labelStyle: TextStyle(color: ChowColors.white),
            hintStyle: TextStyle(color: ChowColors.white)),
      ),
    );
  }

  void _submitForm(BuildContext context, String query) {
    final searchCubit = context.read<SearchCubit>();
    searchCubit.fetchSearchResults(query);
  }
}
