import 'dart:io';

import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_excepiton.dart';
import 'package:cuidapet_mobile/app/models/confirm_login_model.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:cuidapet_mobile/app/repositories/user/i_user_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRepository implements IUserRepository {

  final IRestClient _restClient;
  final IAppLogger _logger;

  UserRepository({
    required IRestClient restClient,
    required IAppLogger logger,
  }) : _restClient = restClient,
       _logger = logger;

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    
    try {
      await _restClient.unauth().post(
        "/auth/register",
        data: {
          "email": email,
          "password": password,
        }
      );
    } on RestClientExcepiton catch (e, s) {
      if(e.statusCode == 400 && e.response.data["message"].contains("Usuário já cadastrado")) {
        _logger.error(e.error, e, s);

        throw UserExistsException();
      }

      _logger.error("Erro ao cadastrar o usuário", e, s);

      throw Failure(
        message: "Erro ao registrar usuário",
      );
    }
  }
  
  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    
    try {
      final result = await _restClient.unauth().post(
        "/auth/",
        data: {
          "login": email,
          "password": password,
          "social_login": false,
          "supplier_user": false,
        }
      );

      return result.data["access_token"];
    
    } on RestClientExcepiton catch (e, s) {

      if(e.statusCode == 403) {

        _logger.error("Usuário inconsistente", e, s);

        throw Failure(message: "Usuário inconsistente. Entre em contato com o suporte");
      }

      _logger.error("Erro ao realizar login", e, s);

      throw Failure(message: "Erro ao realizar login, tente novamente mais tarde");
    }
  }

  @override
  Future<ConfirmLoginModel> confirmLogin() async {

    final deviceToken = await FirebaseMessaging.instance.getToken();
    
    try {
      
      final result = await _restClient.auth().patch(
        "/auth/confirm",
        data: {
          "ios_token": Platform.isIOS ? deviceToken : null,
          "android_token": Platform.isAndroid ? deviceToken : null,
        }
      );

      return ConfirmLoginModel.fromMap(result.data);

    } on RestClientExcepiton catch(e, s) {
      
      _logger.error("Erro ao confirmar login", e, s);

      throw Failure(message: "Erro ao confirmar login");
    }
  }

  @override
  Future<UserModel> getUserLogged() async {
    
    try {
      
      final result = await _restClient.auth().get(
        "/user/",
      );

      return UserModel.fromMap(result.data);

    } on RestClientExcepiton catch(e, s) {
      
      _logger.error("Erro ao buscar dados do usuário logado", e, s);

      throw Failure(message: "Erro ao buscar dados do usuário logado");
    }
  }

  @override
  Future<String> loginSocial({
    required SocialNetworkModel model,
  }) async {
    
    try {
      final result = await _restClient.unauth().post(
        "/auth/",
        data: {
            'login': model.email,
            'social_login': true,
            'avatar': model.avatar,
            'social_type': model.type,
            'social_key': model.id,
            'supplier_user': false,
        }
      );
      
      return result.data['access_token'];
    } on RestClientExcepiton catch (e,s) {
      if(e.statusCode == 403) {

        _logger.error("Usuário inconsistente", e, s);

        throw Failure(message: "Usuário inconsistente. Entre em contato com o suporte");
      }

      _logger.error("Erro ao realizar login", e, s);

      throw Failure(message: "Erro ao realizar login, tente novamente mais tarde");
    }
  }

}
