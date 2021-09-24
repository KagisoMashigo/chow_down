import 'package:chow_down/pages/recipes/bloc/recipe_page_cubit.dart';
import 'package:chow_down/pages/recipes/bloc/recipe_page_state.dart';
import 'package:chow_down/services/api/spoonacular_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class RecipePage extends StatefulWidget {
  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeCubit(RecipeInformationService()),
      child: Container(
        child: BlocConsumer<RecipeCubit, RecipeState>(
          listener: (context, state) {
            if (state is RecipeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  onSubmitted: (value) => submitCityName(context, value),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: "Enter a city",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final recipeCubit = BlocProvider.of<RecipeCubit>(context);
    recipeCubit.getRecipes(cityName);
  }
}

// class SearchBar {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 50),
//       child: TextField(
//         onSubmitted: (value) => submitCityName(context, value),
//         textInputAction: TextInputAction.search,
//         decoration: InputDecoration(
//           hintText: "Enter a city",
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//           suffixIcon: Icon(Icons.search),
//         ),
//       ),
//     );
//   }


// }
