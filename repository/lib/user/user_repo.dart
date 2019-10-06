abstract class UserRepo{
  Future<bool> isAuthenticated();
  Future<void> authenticate();
  Future<String> getUserId();
}