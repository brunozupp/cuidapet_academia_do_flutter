import 'package:cuidapet_mobile/app/models/confirm_login_model.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';

abstract class IUserRepository {

  Future<void> register({
    required String email,
    required String password,
  });

  Future<String> login({
    required String email,
    required String password,
  });

  Future<ConfirmLoginModel> confirmLogin();

  Future<UserModel> getUserLogged();

  Future<String> loginSocial({
    required SocialNetworkModel model,
  });
}