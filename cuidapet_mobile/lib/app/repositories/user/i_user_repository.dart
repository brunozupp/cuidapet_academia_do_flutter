abstract class IUserRepository {

  Future<void> register({
    required String email,
    required String password,
  });

  Future<String> login({
    required String email,
    required String password,
  });
}