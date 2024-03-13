import 'package:chow_down/core/models/spoonacular/recipe_model.dart';

abstract class ExtractState {
  const ExtractState();
}

// The initial search bar
class ExtractInitial extends ExtractState {
  const ExtractInitial();
}

class ExtractPending extends ExtractState {
  const ExtractPending();
}

class ExtractLoaded extends ExtractState {
  const ExtractLoaded(this.extractedResult);

  final Recipe extractedResult;

  @override
  String toString() => 'ExtractLoaded{extractedResult: $extractedResult}';
}

class ExtractError extends ExtractState {
  final String message;
  final int? code;

  const ExtractError(this.message, this.code);

  @override
  String toString() => 'ExtractError{message: $message, code: $code}';
}
