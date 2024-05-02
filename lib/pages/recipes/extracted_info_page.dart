/// DEPRECATED: This page is no longer in use
/// it's functionality has been merged with RecipeInfoPage
/// and is now a reference for the old layout
/// 
/// 
// class ExtractedInfoPage extends StatelessWidget {
//   final String title;
//   final int id;
//   final String? sourceUrl;

//   const ExtractedInfoPage({
//     Key? key,
//     required this.title,
//     required this.id,
//     this.sourceUrl,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomLogoAppBar(
//       imgUrl: 'assets/images/chow_down.png',
//       title: title,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: CachedNetworkImageProvider(
//               'https://images.unsplash.com/photo-1604147706283-d7119b5b822c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bGlnaHQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         alignment: Alignment.center,
//         child: BlocConsumer<RecipeInfoBloc, RecipeInfoState>(
//           listenWhen: (previous, current) => previous != current,
//           listener: (context, state) {
//             if (state is RecipeInfoError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   // TODO: use generic error message for now
//                   content: Text(state.message ?? 'An unknown error occurred'),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is RecipeInfoLoading) {
//               return _buildLoading();
//             } else if (state is RecipeInfoLoaded) {
//               return _buildContents(context, state.recipe);
//             } else {
//               // error state snackbar
//               return _buildErrorInput(context, state);
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorInput(BuildContext context, RecipeInfoState state) =>
//       EmptyContent(
//         message: 'The was a problem saving this recipe. Please try again..',
//         title: 'Something went wrong...',
//         icon: Icons.error_outline_sharp,
//       );

//   Widget _buildLoading() => Center(
//         child: CircularProgressIndicator(
//           color: Colors.black,
//         ),
//       );

//   Widget _buildContents(BuildContext context, Recipe recipe) {
//     final List<bool> _isSelected = [];
//     _populateButtonList(TAB_OPTIONS, _isSelected);

//     return SingleChildScrollView(
//       physics: BouncingScrollPhysics(),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: CachedNetworkImage(
//                   imageUrl: recipe.image,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: Spacing.md),
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: 4.5 * Responsive.ratioHorizontal),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         recipe.title,
//                         style: TextStyle(
//                           fontSize: 7 * Responsive.ratioHorizontal,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     ChowSaveButton(
//                       onTap: () {
//                         // Perform save action here
//                         // You may need to pass a function to handle the save operation
//                       },
//                       isButtonTapped: false, // Set button tapped state
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: Spacing.md),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: ChowColors.white,
//                       borderRadius: BorderRadius.circular(18.0),
//                     ),
//                     child: ToggleButtons(
//                       renderBorder: false,
//                       borderRadius: BorderRadius.circular(18.0),
//                       borderWidth: 0,
//                       children: TAB_OPTIONS
//                           .map(
//                             (tabName) => Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12),
//                               child: Text(
//                                 tabName,
//                                 style: const TextStyle(fontSize: 15),
//                               ),
//                             ),
//                           )
//                           .toList(),
//                       isSelected: _isSelected,
//                       onPressed: (int newIndex) {
//                         // Handle toggle button press
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: Spacing.md),
//                 // You may need to pass some functions or variables to below widget
//                 RecipeDescCard(
//                   veryHealthy: recipe.veryHealthy!,
//                   readyInMinutes: recipe.readyInMinutes!,
//                   servings: recipe.servings!,
//                   creditsText: recipe.creditsText!,
//                   glutenFree: recipe.glutenFree!,
//                   vegetarian: recipe.vegetarian!,
//                   summary: recipe.summary,
//                   ingredients: recipe.extendedIngredients,
//                   sourceUrl: recipe.sourceUrl!,
//                 ),
//                 SizedBox(height: Spacing.md),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _populateButtonList(List data, List<bool> isSelected) {
//     for (var i = 0; i < data.length; i++) {
//       if (i == 0) {
//         isSelected.add(true);
//       } else {
//         isSelected.add(false);
//       }
//     }
//   }
// }
