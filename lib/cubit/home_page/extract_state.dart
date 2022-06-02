part of 'extract_cubit.dart';

abstract class ExtractState extends Equatable {
  const ExtractState();

  @override
  List<Object> get props => [];
}

// The initial search bar
class ExtractInitial extends ExtractState {
  const ExtractInitial();
}

class ExtractLoading extends ExtractState {
  const ExtractLoading();
}

class ExtractLoaded extends ExtractState {
  const ExtractLoaded(this.extractedResult);
  final RecipeCardInfo extractedResult;

  // TODO: incorporate freezed later on as this is not prod viable
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExtractLoaded && other.extractedResult == extractedResult;
  }

  @override
  int get hashCode => extractedResult.hashCode;
}

class ExtractError extends ExtractState {
  final String message;
  const ExtractError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExtractError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
