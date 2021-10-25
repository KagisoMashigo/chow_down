import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recipe_home_state.dart';

class RecipeHomeCubit extends Cubit<RecipeHomeState> {
  RecipeHomeCubit() : super(RecipeHomeInitial());
}
