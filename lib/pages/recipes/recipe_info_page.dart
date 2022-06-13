// 🐦 Flutter imports:
import 'package:chow_down/components/cards/detail_card.dart';
import 'package:chow_down/components/design/chow.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';

class RecipeInfoPage extends StatefulWidget {
  const RecipeInfoPage({Key key, @required this.title, this.id, this.sourceUrl})
      : super(key: key);

  /// Recipe title
  final String title;

  /// Recipe id
  final int id;

  /// Recipe url
  final String sourceUrl;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  void initState() {
    super.initState();
    // Will change this to a DB call once user can save recipes
    Provider.of<RecipeInfoCubit>(context, listen: false)
        .fetchRecipeInformation(widget.id, widget.sourceUrl);
  }

  @override
  Widget build(BuildContext conxtext) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: widget.title,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
            fit: BoxFit.cover,
          ),
        ),
        // padding: EdgeInsets.all(11.1),
        alignment: Alignment.center,
        child: BlocConsumer<RecipeInfoCubit, RecipeInfoState>(
          listener: (context, state) {
            if (state is RecipInfoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RecipeInfoLoading) {
              return _buildLoading();
            } else if (state is RecipeInfoLoaded) {
              return _buildContents(state.recipe);
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
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );

  Widget _buildContents(Recipe recipe) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.network(
                  recipe.image,
                  // width: 3 * Responsive.ratioHorizontal,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // verticalDivider(factor: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        recipe.title,
                        style: TextStyle(
                          fontSize: 7 * Responsive.ratioHorizontal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => print('saved!'),
                      iconSize: 35,
                      icon: const Icon(
                        Icons.save_rounded,
                      ),
                    ),
                  ],
                ),
                // ListView(
                //   scrollDirection: Axis.horizontal,
                //   children: [
                //     Row(
                //       children: <Widget>[
                //         // DetailCard(
                //         //   child: Column(
                //         //     children: <Widget>[
                //         //       Text(
                //         //         "Calories",
                //         //         style: GoogleFonts.lato(color: Colors.grey),
                //         //       ),
                //         //       Text(
                //         //         "174KCal",
                //         //         style: GoogleFonts.lato(
                //         //             color: Colors.grey[900],
                //         //             fontWeight: FontWeight.bold),
                //         //       ),
                //         //     ],
                //         //   ),
                //         //   color: ChowColors.black,
                //         // ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(
                //               color: Color.fromARGB(255, 172, 25, 25),
                //             ),
                //           ),
                //           padding: const EdgeInsets.symmetric(vertical: 16),
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 "Ingredients",
                //                 style: GoogleFonts.lato(color: Colors.grey),
                //               ),
                //               Text(
                //                 "06",
                //                 style: GoogleFonts.lato(
                //                     color: Colors.grey[900],
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(
                //               color: Color.fromARGB(255, 200, 37, 37),
                //             ),
                //           ),
                //           padding: const EdgeInsets.symmetric(vertical: 16),
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 "Time",
                //                 style: GoogleFonts.lato(color: Colors.grey),
                //               ),
                //               Text(
                //                 "3 Hours",
                //                 style: GoogleFonts.lato(
                //                     color: Colors.grey[900],
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         ),
                //         verticalDivider(factor: 2),
                //         DetailCard(
                //           child: Column(
                //             children: <Widget>[
                //               Text(
                //                 "Calories",
                //                 style: GoogleFonts.lato(color: Colors.grey),
                //               ),
                //               Text(
                //                 "174KCal",
                //                 style: GoogleFonts.lato(
                //                     color: Colors.grey[900],
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //           color: ChowColors.black,
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                verticalDivider(factor: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ready In: ${recipe.readyInMinutes.toString()} minutes',
                      style: TextStyle(
                        fontSize: 4 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      'Servings: ${recipe.servings.toString()}',
                      style: TextStyle(
                        fontSize: 4 * Responsive.ratioHorizontal,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    verticalDivider(factor: 4),
                  ],
                ),
                verticalDivider(factor: 2),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By ${recipe.creditsText}',
                        style: TextStyle(
                          fontSize: 4 * Responsive.ratioHorizontal,
                          fontStyle: FontStyle.italic,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // TODO create rating system
                    // const Icon(Icons.stars),
                    // horizontalDivider(factor: 2),
                    // Text(
                    //   '564 ratings',
                    //   style: TextStyle(
                    //     fontSize: 5 * Responsive.ratioHorizontal,
                    //     // fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                    // horizontalDivider(factor: 2),
                    // TextButton(
                    //   onPressed: () => print('rated!'),
                    //   child: Text(
                    //     'rate this recipe',
                    //     style: TextStyle(
                    //       fontSize: 5 * Responsive.ratioHorizontal,
                    //       // fontStyle: FontStyle.italic,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    // horizontalDivider(factor: 4),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gluten Free: ${recipe.glutenFree.toString()}',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          ),
                          verticalDivider(factor: 4),
                          Text(
                            'Vegetarian: ${recipe.vegetarian.toString()}',
                            style: TextStyle(
                              fontSize: 4 * Responsive.ratioHorizontal,
                              // fontStyle: FontStyle.italic,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                verticalDivider(factor: 2.5),
                Center(
                  child: Text(
                    recipe.summary
                        .replaceAll('</b>', '')
                        .replaceAll('<b>', '')
                        .replaceAll('<a href=', '')
                        .replaceAll('</a>', '')
                        .replaceAll('>', '')
                        .replaceAll('"', ''),
                    style: TextStyle(
                      fontSize: 4 * Responsive.ratioHorizontal,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
