// 🐦 Flutter imports:
import 'package:chow_down/components/customAppBar.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/recipe_info/recipe_info_cubit.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/plugins/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RecipeInfoPage extends StatefulWidget {
  const RecipeInfoPage({
    Key key,
    @required this.title,
    this.id,
  }) : super(key: key);

  /// Recipe title
  final String title;

  /// Recipe id
  final int id;

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  void initState() {
    super.initState();
    // Will change this to a DB call once user can save recipes
    Provider.of<RecipeInfoCubit>(context, listen: false)
        .fetchRecipeInformation(widget.id);
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
                'https://images.unsplash.com/photo-1528458876861-544fd1761a91?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1388&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(11.1),
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
              return _buildColumnWithData(state.recipe);
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

  Widget _buildColumnWithData(Recipe recipe) => ListView(
        children: [
          verticalDivider(factor: 2),
          Center(
            child: Text(recipe.summary),
          ),
        ],
      );
}
