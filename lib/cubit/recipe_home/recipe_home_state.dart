// part of 'recipe_home_cubit.dart';

// abstract class SearchState extends Equatable {
//   const SearchState();

//   @override
//   List<Object> get props => [];
// }

// // The initial search bar
// class SearchInitial extends SearchState {
//   const SearchInitial();
// }

// class SearchLoading extends SearchState {
//   const SearchLoading();
// }

// class SearchLoaded extends SearchState {
//   final RecipeCardInfoList searchResultList;
//   const SearchLoaded(this.searchResultList);

//   // TODO: incorporate freezed later on as this is not prod viable
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is SearchLoaded && other.searchResultList == searchResultList;
//   }

//   @override
//   int get hashCode => searchResultList.hashCode;
// }

// class SearchError extends SearchState {
//   final String message;
//   const SearchError(this.message);

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is SearchError && other.message == message;
//   }

//   @override
//   int get hashCode => message.hashCode;
// }
