abstract class AuthenticatedProvider {
  /// Called when the user has signed in
  void init();

  /// Called in case the user has signed out or session expired
  void logout();
}
