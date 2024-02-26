part of 'extract_bloc.dart';

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
  final int? code;

  const ExtractError(this.message, this.code);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExtractError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
