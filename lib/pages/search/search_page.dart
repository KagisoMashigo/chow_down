import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/cubit/search/search_cubit.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('What are we eating?'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1528458876861-544fd1761a91?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1388&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16),
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
    final results = searchResultList.list;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: ListView(
          children: results
              .map((recipe) => GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipeInfoPage(recipeId: recipe.id.toString()),
                      ),
                    ),
                    child: RecipeCard(
                      id: recipe.id,
                      name: recipe.name,
                      imageUrl: recipe.image,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
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
