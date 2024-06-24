// 📦 Package imports:
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:chow_down/blocs/home_page/extract_bloc.dart';
import 'package:chow_down/blocs/home_page/extract_event.dart';
import 'package:chow_down/blocs/home_page/extract_state.dart';
import 'package:chow_down/core/data/remotes/remote_spoonacular/recipe_remote_repository.dart';
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:mocktail/mocktail.dart';

final testRecipe = Recipe(
  id: 1,
  title: 'Test Recipe',
  image: 'test.jpg',
  originalId: 'test.com',
);

void main() {
  group('ExtractBloc', () {
    late ExtractBloc extractBloc;
    late RemoteRecipe mockRecipeRepository;

    setUp(() {
      mockRecipeRepository = MockRecipeRepository();
      extractBloc = ExtractBloc(mockRecipeRepository);
    });

    tearDown(() {
      extractBloc.close();
    });

    test('initial state is ExtractInitial', () {
      expect(extractBloc.state, equals(ExtractInitial()));
    });

    blocTest<ExtractBloc, ExtractState>(
      'emits [ExtractPending, ExtractLoaded] when ExtractRecipe event is a dded',
      build: () {
        when(() => mockRecipeRepository.getExtractedRecipe(any()))
            .thenAnswer((_) async => testRecipe);
        return extractBloc;
      },
      act: (bloc) => bloc.add(ExtractRecipe(url: 'https://example.com')),
      expect: () => [
        ExtractPending(),
        ExtractLoaded(testRecipe),
      ],
    );

    blocTest<ExtractBloc, ExtractState>(
      'emits [ExtractPending, ExtractError] when invalid URL is provided',
      build: () => extractBloc,
      act: (bloc) => bloc.add(ExtractRecipe(url: 'invalidURL')),
      expect: () => [
        ExtractPending(),
        ExtractError('The URL provided is invalid or empty', null),
      ],
    );

    blocTest<ExtractBloc, ExtractState>(
      'emits [ExtractPending, ExtractError] when recipe extraction fails',
      build: () {
        when(() =>
                mockRecipeRepository.getExtractedRecipe('https://example.com'))
            .thenThrow(Exception('Failed to extract recipe'));
        return extractBloc;
      },
      act: (bloc) => bloc.add(ExtractRecipe(url: 'https://example.com')),
      expect: () => [
        ExtractPending(),
        ExtractError('Exception: Failed to extract recipe', null),
      ],
    );
  });
}

class MockRecipeRepository extends Mock implements RemoteRecipe {}
