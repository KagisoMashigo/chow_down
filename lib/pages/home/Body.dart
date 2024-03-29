// 🐦 Flutter imports:
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
import 'package:chow_down/components/snackBar.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/cubit/home_page/extract_cubit.dart';
import 'package:chow_down/pages/recipes/extracted_info_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showSnackbar(
    BuildContext context,
    String errorMessage,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(warningSnackBar(errorMessage));

  final _controller = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: page needs to be refreshable, or does it?
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          onRefresh: () => _pullRefresh(),
          color: ChowColors.red700,
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
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
              child: BlocConsumer<ExtractCubit, ExtractState>(
                listener: (context, state) {
                  if (state is ExtractError) {
                    return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ExtractLoading) {
                    return _buildLoading();
                  } else if (state is ExtractLoaded) {
                    return _buildColumnWithData(state.extractedResult);
                  } else {
                    // error state snackbar
                    return _buildInitialInput(state);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInitialInput(ExtractState state) => Column(
        children: [
          verticalDivider(factor: 3.5),
          Image.asset(
            'assets/images/chow_down.png',
            height: 18.5 * Responsive.ratioVertical,
            width: 18.5 * Responsive.ratioVertical,
            fit: BoxFit.cover,
          ),
          verticalDivider(factor: 5),
          state is ExtractInitial
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * Responsive.ratioHorizontal),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.url,
                        style: TextStyle(color: ChowColors.white),
                        onSubmitted: (url) {
                          if (url.isNotEmpty) {
                            _submitForm(context, url);
                            setState(() => _validate = false);
                          } else {
                            setState(() => _validate = true);
                          }
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: ChowColors.offWhite),
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          // TODO: error handling if url is not recipe
                          hintText: "Enter a recipe url here",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ChowColors.white,
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                            color: ChowColors.white,
                          ),
                        ),
                      ),
                    ),
                    verticalDivider(factor: 1),
                    HelpCard(),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * Responsive.ratioHorizontal),
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.url,
                        style: TextStyle(color: ChowColors.white),
                        onSubmitted: (url) {
                          if (url.isNotEmpty) {
                            _submitForm(context, url);
                            setState(() => _validate = false);
                          } else {
                            setState(() => _validate = true);
                          }
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: ChowColors.offWhite),
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          // TODO: error handling if url is not recipe
                          hintText: "Enter a recipe url here",
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: ChowColors.white,
                              width: 0.0,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintStyle: TextStyle(
                            color: ChowColors.white,
                          ),
                        ),
                      ),
                    ),
                    verticalDivider(factor: 2),
                    HelpCard(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5 * Responsive.ratioHorizontal),
                      child: EmptyContent(
                        message: 'Try refreshing the page.',
                        title: 'Something went wrong...',
                        icon: Icons.error_outline_sharp,
                      ),
                    ),
                  ],
                ),
        ],
      );

  Future<void> _pullRefresh() async {
    final extractCubit = context.read<ExtractCubit>();
    extractCubit.refresh();
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: ChowColors.white,
      ),
    );
  }

  Widget _buildColumnWithData(Recipe searchResult) {
    final result = searchResult;
    return Column(
      children: [
        verticalDivider(factor: 2),
        Image.asset(
          'assets/images/chow_down.png',
          height: 18.5 * Responsive.ratioVertical,
          width: 18.5 * Responsive.ratioVertical,
          fit: BoxFit.fill,
        ),
        verticalDivider(factor: 2),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 5 * Responsive.ratioHorizontal),
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.url,
            style: TextStyle(color: ChowColors.white),
            onSubmitted: (url) {
              if (url.isNotEmpty) {
                _submitForm(context, url);
                setState(() => _validate = false);
              } else {
                setState(() => _validate = true);
              }
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              errorStyle: TextStyle(color: ChowColors.offWhite),
              hintText: "Enter a recipe url here",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: ChowColors.white,
                  width: 0.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              hintStyle: TextStyle(
                color: ChowColors.white,
              ),
            ),
          ),
        ),
        verticalDivider(factor: 2),
        HelpCard(),
        verticalDivider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5 * Responsive.ratioHorizontal,
          ),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExtractedInfoPage(
                  title: result.title,
                  id: result.id,
                  sourceUrl: result.sourceUrl,
                ),
              ),
            ),
            child: RecipeCard(
              loadingColor: ChowColors.red700,
              id: result.id,
              name: result.title,
              imageUrl: result.image,
              url: result.sourceUrl,
              glutenFree: result.glutenFree,
              readyInMinutes: result.readyInMinutes,
              vegetarian: result.vegetarian,
              vegan: result.vegan,
              servings: result.servings,
            ),
          ),
        ),
        verticalDivider(factor: 4),
      ],
    );
  }

  void _submitForm(BuildContext context, String url) {
    final extractCubit = context.read<ExtractCubit>();
    extractCubit.fetchExtractedResult(url);
    _controller.clear();
  }
}
