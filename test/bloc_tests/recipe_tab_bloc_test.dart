import 'package:bloc_test/bloc_test.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_bloc.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_event.dart';
import 'package:chow_down/blocs/recipe_tab/recipe_tab_state.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreDatabase extends Mock implements FirestoreDatabase {}

class MockRecipe extends Mock implements Recipe {}

void main() {
  late RecipeTabBloc recipeTabBloc;
  late MockFirestoreDatabase mockFirestoreDatabase;

  setUp(() {
    mockFirestoreDatabase = MockFirestoreDatabase();
    recipeTabBloc = RecipeTabBloc(mockFirestoreDatabase);

    // Register the fallback values for any unregistered types
    registerFallbackValue(FetchHomeRecipesEvent());
    registerFallbackValue(DeleteRecipeEvent(MockRecipe()));
    registerFallbackValue(DeleteEntireCollectionEvent());
    registerFallbackValue(Refresh());
  });

  tearDown(() {
    recipeTabBloc.close();
  });

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabLoaded] when FetchHomeRecipesEvent is added and recipes are retrieved',
    build: () {
      when(() => mockFirestoreDatabase.retrieveSavedRecipes())
          .thenAnswer((_) async => [MockRecipe()]);
      return recipeTabBloc;
    },
    act: (bloc) => bloc.add(FetchHomeRecipesEvent()),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabLoaded(recipeCardList: [MockRecipe()]),
    ],
  );

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabInitial] when FetchHomeRecipesEvent is added and no recipes are retrieved',
    build: () {
      when(() => mockFirestoreDatabase.retrieveSavedRecipes())
          .thenAnswer((_) async => []);
      return recipeTabBloc;
    },
    act: (bloc) => bloc.add(FetchHomeRecipesEvent()),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabInitial(),
    ],
  );

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabLoaded] when DeleteRecipeEvent is added and recipes are retrieved',
    build: () {
      when(() => mockFirestoreDatabase.deleteRecipe(any()))
          .thenAnswer((_) async {});
      when(() => mockFirestoreDatabase.retrieveSavedRecipes())
          .thenAnswer((_) async => [MockRecipe()]);
      return recipeTabBloc;
    },
    act: (bloc) => bloc.add(DeleteRecipeEvent(MockRecipe())),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabLoaded(recipeCardList: [MockRecipe()]),
    ],
  );

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabInitial] when DeleteRecipeEvent is added and no recipes are retrieved',
    build: () {
      when(() => mockFirestoreDatabase.deleteRecipe(any()))
          .thenAnswer((_) async {});
      when(() => mockFirestoreDatabase.retrieveSavedRecipes())
          .thenAnswer((_) async => []);
      return recipeTabBloc;
    },
    act: (bloc) => bloc.add(DeleteRecipeEvent(MockRecipe())),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabInitial(),
    ],
  );

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabInitial] when DeleteEntireCollectionEvent is added',
    build: () {
      when(() => mockFirestoreDatabase.deleteAllRecipes())
          .thenAnswer((_) async {});
      return recipeTabBloc;
    },
    act: (bloc) => bloc.add(DeleteEntireCollectionEvent()),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabInitial(),
    ],
  );

  blocTest<RecipeTabBloc, RecipeTabState>(
    'emits [RecipeTabLoading, RecipeTabInitial] when Refresh event is added',
    build: () => recipeTabBloc,
    act: (bloc) => bloc.add(Refresh()),
    expect: () => [
      RecipeTabLoading(recipeCardList: []),
      RecipeTabInitial(),
    ],
  );
}
