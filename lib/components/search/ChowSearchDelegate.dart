// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

class CostcoSearchDelegate extends SearchDelegate {
  CostcoSearchDelegate({
    @required this.searchResults,
    this.enableSuggestions = true,
  });
  List<Recipe> searchResults;

  bool enableSuggestions;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Recipe> products = searchResults.where((searchResult) {
      final result = searchResult.title.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return products.isEmpty
        ? const Center(
            child: Text('No results found'),
          )
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                // child: CoreHorizontalCard(
                //   title: product.name,
                //   price: product.price,
                //   destination: 'costco://product/${product.id}',
                //   imageUrl: product.image,
                // ),
              );
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: make dynamic
    List<String> departmentList = [
      'Apple',
      'Asus',
      'Dell',
      'HP',
      'Microsoft',
      'MSI',
    ];

    List<String> suggestions = query.isEmpty
        ? departmentList
        : departmentList.where((department) {
            final result = department.toLowerCase();
            final input = query.toLowerCase();

            return result.contains(input);
          }).toList();

    return enableSuggestions
        ? ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: ((context, index) {
              final suggestion = suggestions[index];

              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  query = suggestion;

                  showResults(context);
                },
              );
            }),
          )
        : Container();
  }
}
