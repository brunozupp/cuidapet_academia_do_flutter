abstract class IUserService {

  Future<void> register({
    required String email,
    required String password,
  });
}