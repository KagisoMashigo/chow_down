// 🐦 Flutter imports:
import 'dart:developer';

import 'package:chow_down/components/design/spacing.dart';
import 'package:chow_down/components/forms/extract_recipe_form.dart';
import 'package:chow_down/cubit/home_page/extract_bloc.dart';
import 'package:chow_down/cubit/home_page/extract_event.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🌎 Project imports:
import 'package:chow_down/components/cards/expanded_help_card.dart';
import 'package:chow_down/components/cards/recipe_card.dart';
import 'package:chow_down/components/design/color.dart';
import 'package:chow_down/components/design/responsive.dart';
import 'package:chow_down/components/empty_content.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/pages/recipes/extracted_info_page.dart';

class HomePage extends StatelessWidget {
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  log('Current state: $state');
                  if (state is ExtractPending) {
                    return _buildLoading();
                  } else if (state is ExtractLoaded) {
                    return _buildColumnWithData(state.extractedResult, context);
                  } else {
                    // error state snackbar
                    return _buildInitialInput(context, state);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context, ExtractState state) {
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
        ExtractRecipeForm(),
        SizedBox(height: Spacing.sm),
        HelpCard(),
        SizedBox(height: Spacing.xsm),
        if (state is! ExtractInitial)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Spacing.sm,
            ),
            child: EmptyContent(
              message: 'Try refreshing the page.',
              title: 'Something went wrong...',
              icon: Icons.error_outline_sharp,
            ),
          ),
      ],
    );
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          color: ChowColors.white,
        ),
      );

  Widget _buildColumnWithData(Recipe searchResult, BuildContext context) {
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
        ExtractRecipeForm(),
        SizedBox(height: Spacing.sm),
        HelpCard(),
        SizedBox(height: Spacing.xsm),

        // This is the recipe card that is displayed after the user has submitted a URL
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * Responsive.ratioHorizontal),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExtractedInfoPage(
                  title: searchResult.title,
                  id: searchResult.id,
                  sourceUrl: searchResult.sourceUrl,
                ),
              ),
            ),
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

  Future<void> _pullRefresh(BuildContext context) async =>
      Future.delayed(Duration(milliseconds: 1500), () {
        context.read<ExtractBloc>().add(Refresh());
      });
}
