abstract class IUserRepository {

  Future<void> register({
    required String email,
    required String password,
  });
}