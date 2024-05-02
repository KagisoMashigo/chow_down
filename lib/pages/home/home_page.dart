// 🐦 Flutter imports:
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/pages/recipes/recipe_info_page.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/home_page/extract_bloc.dart';
import 'package:chow_down/blocs/home_page/extract_event.dart';
import 'package:chow_down/blocs/home_page/extract_state.dart';
import 'package:chow_down/components/alert_dialogs/floating_feedback.dart';
import 'package:chow_down/components/cards/expanded_help_card.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/forms/chow_form.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          onRefresh: () => _pullRefresh(context),
          color: ChowColors.black,
          child: SingleChildScrollView(
            child: Container(
              height: Responsive.isSmallScreen()
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.91,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://images.unsplash.com/photo-1558855410-3112e253d755?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDZ8fGljZSUyMGNyZWFtfGVufDB8MXwwfHw%3D&auto=format&fit=crop&w=800&q=60'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.only(top: 4 * Responsive.ratioVertical),
              child: BlocConsumer<ExtractBloc, ExtractState>(
                listener: (context, state) {
                  if (state is ExtractError) {
                    FloatingFeedback(
                      message: state.message,
                      style: FloatingFeedbackStyle.alert,
                      duration: Duration(seconds: 3),
                    ).show(context);
                  }
                },
                builder: (context, state) {
                  if (state is ExtractPending) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ChowColors.white,
                      ),
                    );
                  }

                  return Column(
                    children: [
                      SizedBox(height: Spacing.md),
                      Image.asset(
                        'assets/images/chow_down.png',
                        height: Spacing.massive,
                        width: Spacing.massive,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: Spacing.md),
                      ChowForm(
                        submitForm: (context, url) => context
                            .read<ExtractBloc>()
                            .add(ExtractRecipe(url: url)),
                      ),
                      SizedBox(height: Spacing.sm),
                      if (state is! ExtractPending) HelpCard(),
                      SizedBox(height: Spacing.xsm),
                      if (state is ExtractLoaded)
                        _buildColumnWithData(state.extractedResult, context),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnWithData(Recipe searchResult, BuildContext context) {
    return Column(
      children: [
        // This is the recipe card that is displayed after the user has submitted a URL
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Spacing.sm),
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<RecipeInfoBloc>(context).add(
                FetchRecipeInformation(
                  id: searchResult.id,
                  sourceUrl: searchResult.sourceUrl!,
                ),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeInfoPage(
                    title: searchResult.title,
                    id: searchResult.id,
                    sourceUrl: searchResult.sourceUrl!,
                  ),
                ),
              );
            },
            child: RecipeCard(
              loadingColor: ChowColors.red700,
              id: searchResult.id,
              name: searchResult.title,
              imageUrl: searchResult.image,
              url: searchResult.sourceUrl!,
              glutenFree: searchResult.glutenFree!,
              readyInMinutes: searchResult.readyInMinutes!,
              vegetarian: searchResult.vegetarian!,
              vegan: searchResult.vegan!,
              servings: searchResult.servings!,
            ),
          ),
        ),
        SizedBox(height: Spacing.lg),
      ],
    );
  }

  Future<void> _pullRefresh(BuildContext context) async => Future.delayed(
        Duration(milliseconds: 1500),
        () {
          context.read<ExtractBloc>().add(RefreshHome());
        },
      );
}
