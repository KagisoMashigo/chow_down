// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/recipe_model.dart';
import 'package:equatable/equatable.dart';

abstract class ExtractState extends Equatable {
  const ExtractState();
}

// The initial search bar
class ExtractInitial extends ExtractState {
  const ExtractInitial();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ExtractInitial{}';
}

class ExtractPending extends ExtractState {
  const ExtractPending();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ExtractPending{}';
}

class ExtractLoaded extends ExtractState {
  final Recipe extractedResult;

  const ExtractLoaded(this.extractedResult);

  @override
  List<Object?> get props => [extractedResult];

  @override
  String toString() => 'ExtractLoaded{extractedResult: $extractedResult}';
}

class ExtractError extends ExtractState {
  final String message;
  final int? code;

  const ExtractError(this.message, this.code);

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'ExtractError{message: $message, code: $code}';
}
