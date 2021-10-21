import 'package:chow_down/cubit/search_cubit.dart';
import 'package:chow_down/domain/models/search/search_result_model.dart';
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
      appBar: AppBar(
        title: Text("Weather Search"),
      ),
      body: Container(
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
              return buildInitialInput();
            } else if (state is SearchLoading) {
              return buildLoading();
            } else if (state is SearchLoaded) {
              return buildColumnWithData(state.searchResultList);
            } else {
              // error state snackbar
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: SearchInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(SearchResultList searchResultList) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // Text(
        //   weather.cityName,
        //   style: TextStyle(
        //     fontSize: 40,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // Text(
        //   // Display the temperature with 1 decimal place
        //   "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
        //   style: TextStyle(fontSize: 80),
        // ),
        SearchInputField(),
      ],
    );
  }
}

class SearchInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitRecipe(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Search a recipe",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitRecipe(BuildContext context, String recipeName) {
    final searchCubit = context.read<SearchCubit>();
    searchCubit.fetchRecipesList();
  }
}
