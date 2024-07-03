class APIPath {
  static String savedRecipes(String uid) => 'users/$uid/saved_recipes/';

  static String editedRecipes(String uid) => 'users/$uid/edited_recipes/';
}
