import 'package:equatable/equatable.dart';

abstract class EditRecipeState extends Equatable {
  const EditRecipeState();
}

class EditRecipeInitial extends EditRecipeState {
  const EditRecipeInitial();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeInitial{}';
}

class EditRecipePending extends EditRecipeState {
  const EditRecipePending();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipePending{}';
}

class EditRecipeSuccess extends EditRecipeState {
  const EditRecipeSuccess();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeSuccess{}';
}

class EditRecipeFailure extends EditRecipeState {
  const EditRecipeFailure();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'EditRecipeFailure{}';
}
