import 'package:bloc_test/bloc_test.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_bloc.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_event.dart';
import 'package:chow_down/blocs/recipe_info/recipe_info_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/models/error/error.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteRecipe extends Mock implements RemoteRecipe {}

class MockFirestoreDatabase extends Mock implements FirestoreDatabase {}

class MockRecipe extends Mock implements Recipe {}

void main() {
  late RecipeInfoBloc recipeInfoBloc;
  late MockRemoteRecipe mockRemoteRecipe;
  late MockFirestoreDatabase mockFirestoreDatabase;

  setUp(() {
    mockRemoteRecipe = MockRemoteRecipe();
    mockFirestoreDatabase = MockFirestoreDatabase();
    recipeInfoBloc = RecipeInfoBloc(mockRemoteRecipe, mockFirestoreDatabase);

    // Register the fallback values for any unregistered types
    registerFallbackValue(FetchRecipe(id: 1, url: 'http://example.com'));
    registerFallbackValue(SaveRecipe(recipe: MockRecipe()));
    registerFallbackValue(
        FetchRecipeInformation(id: 1, sourceUrl: 'http://example.com'));
  });

  tearDown(() {
    recipeInfoBloc.close();
  });

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits [RecipeInfoLoading, RecipeInfoLoaded] when FetchRecipe event is added and recipe is retrieved',
    build: () {
      when(() => mockRemoteRecipe.getExistingRecipe(any(), any()))
          .thenAnswer((_) async => MockRecipe());
      return recipeInfoBloc;
    },
    act: (bloc) => bloc.add(FetchRecipe(id: 1, url: 'http://example.com')),
    expect: () => [
      RecipeInfoLoading(id: 1, url: 'http://example.com'),
      RecipeInfoLoaded(recipe: MockRecipe()),
    ],
  );

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits [RecipeInfoLoading, RecipeInfoError] when FetchRecipe event is added and fetch fails',
    build: () {
      when(() => mockRemoteRecipe.getExistingRecipe(any(), any()))
          .thenThrow(Failure(message: 'Failed to fetch recipe'));
      return recipeInfoBloc;
    },
    act: (bloc) => bloc.add(FetchRecipe(id: 1, url: 'http://example.com')),
    expect: () => [
      RecipeInfoLoading(id: 1, url: 'http://example.com'),
      RecipeInfoError(
          message: 'Failed to fetch recipe', id: 1, url: 'http://example.com'),
    ],
  );

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits no states when SaveRecipe event is added and save is successful',
    build: () {
      when(() => mockFirestoreDatabase.saveRecipe(any()))
          .thenAnswer((_) async {});
      return recipeInfoBloc;
    },
    act: (bloc) => bloc.add(SaveRecipe(recipe: MockRecipe())),
    expect: () => [],
  );

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits [RecipeInfoError] when SaveRecipe event is added and save fails',
    build: () {
      when(() => mockFirestoreDatabase.saveRecipe(any()))
          .thenThrow(Failure(message: 'Failed to save recipe'));
      return recipeInfoBloc;
    },
    act: (bloc) => bloc.add(SaveRecipe(recipe: MockRecipe())),
    expect: () => [
      RecipeInfoError(
          message: 'Failed to save recipe', id: 1, url: 'http://example.com'),
    ],
  );

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits [RecipeInfoLoading, RecipeInfoLoaded] when FetchRecipeInformation event is added and recipe information is retrieved',
    build: () {
      when(() => mockRemoteRecipe.getExistingRecipe(any(), any()))
          .thenAnswer((_) async => MockRecipe());
      return recipeInfoBloc;
    },
    act: (bloc) => bloc
        .add(FetchRecipeInformation(id: 1, sourceUrl: 'http://example.com')),
    expect: () => [
      RecipeInfoLoading(id: 1, url: 'http://example.com'),
      RecipeInfoLoaded(recipe: MockRecipe()),
    ],
  );

  blocTest<RecipeInfoBloc, RecipeInfoState>(
    'emits [RecipeInfoLoading, RecipeInfoError] when FetchRecipeInformation event is added and fetch fails',
    build: () {
      when(() => mockRemoteRecipe.getExistingRecipe(any(), any()))
          .thenThrow(Failure(message: 'Failed to fetch recipe information'));
      return recipeInfoBloc;
    },
    act: (bloc) => bloc
        .add(FetchRecipeInformation(id: 1, sourceUrl: 'http://example.com')),
    expect: () => [
      RecipeInfoLoading(id: 1, url: 'http://example.com'),
      RecipeInfoError(
          message: 'Failed to fetch recipe information',
          id: 1,
          url: 'http://example.com'),
    ],
  );
}
