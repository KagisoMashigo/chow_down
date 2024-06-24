import 'package:bloc_test/bloc_test.dart';
import 'package:chow_down/blocs/search/search_bloc.dart';
import 'package:chow_down/blocs/search/search_event.dart';
import 'package:chow_down/blocs/search/search_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/search_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/core/models/spoonacular/search_result_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

final searchResult = Recipe(
  id: 1,
  originalId: '1',
  title: 'Test Recipe',
  image: 'https://test.com/image.jpg',
  sourceUrl: 'https://test.com',
  glutenFree: true,
  readyInMinutes: 30,
  vegetarian: true,
  vegan: true,
  servings: 4,
);

final searchReults = [
  searchResult,
  searchResult.copyWith(
    id: 2,
    originalId: '2',
    title: 'Test Recipe 2',
    image: 'https://test.com/image2.jpg',
    sourceUrl: 'https://test.com/2',
    glutenFree: false,
    readyInMinutes: 60,
    vegetarian: false,
    vegan: false,
    servings: 2,
  ),
  searchResult.copyWith(
    id: 3,
    originalId: '3',
    title: 'Test Recipe 3',
    image: 'https://test.com/image3.jpg',
    sourceUrl: 'https://test.com/3',
    glutenFree: true,
    readyInMinutes: 45,
    vegetarian: true,
    vegan: true,
    servings: 6,
  ),
  searchResult.copyWith(
    id: 4,
    originalId: '4',
    title: 'Test Recipe 4',
    image: 'https://test.com/image4.jpg',
    sourceUrl: 'https://test.com/4',
    glutenFree: false,
    readyInMinutes: 20,
    vegetarian: false,
    vegan: false,
    servings: 3,
  ),
];
final recipeCardInfoList = RecipeCardInfoList(results: searchReults);

void main() {
  group('SearchBloc', () {
    late SearchBloc searchBloc;
    late RemoteSearchRepository mockSearchRepository;

    setUp(() {
      mockSearchRepository = MockRemoteSearchRepository();
      searchBloc = SearchBloc(mockSearchRepository);
    });

    tearDown(() {
      searchBloc.close();
    });

    test('initial state is SearchInitial', () {
      expect(searchBloc.state, equals(SearchInitial()));
    });

    blocTest<SearchBloc, SearchState>(
      'emits [SearchPending, SearchLoaded] when SearchRecipes event is added',
      build: () {
        when(() => mockSearchRepository.getRecipesList(any()))
            .thenAnswer((_) async => recipeCardInfoList);
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchRecipes(query: 'test')),
      expect: () async => [
        SearchLoading(),
        SearchLoaded(searchResultList: recipeCardInfoList),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchError] when search fails',
      build: () {
        when(() => mockSearchRepository.getRecipesList(any()))
            .thenThrow(Failure(message: 'Failed to search recipes'));
        return searchBloc;
      },
      act: (bloc) => bloc.add(SearchRecipes(query: 'test')),
      expect: () => [
        SearchLoading(),
        SearchError(message: 'Failed to search recipes'),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'emits [SearchLoading, SearchError] when search has empty query',
      build: () => searchBloc,
      act: (bloc) => bloc.add(SearchRecipes(query: '')),
      expect: () => [
        SearchLoading(),
        SearchError(message: 'The query provided is invalid or empty'),
      ],
    );
  });
}

class MockRemoteSearchRepository extends Mock
    implements RemoteSearchRepository {}
