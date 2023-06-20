import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInterceptor extends Interceptor {

  final ILocalSecureStorage _localSecureStorage;
  final IAppLogger _logger;
  final AuthStore _authStore;

  AuthInterceptor({
    required ILocalSecureStorage localSecureStorage,
    required IAppLogger logger,
    required AuthStore authStore,
  }) : _localSecureStorage = localSecureStorage,
       _logger = logger,
       _authStore = authStore;
  
  // Antes de enviar para o servidor
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    
    final authRequired = options.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

    if(authRequired) {

      final accessToken = await _localSecureStorage.read(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);

      if(accessToken == null) {
        await _authStore.logout();
        
        return handler.reject(
          DioError(
            requestOptions: options,
            error: "Expire Token",
            type: DioErrorType.cancel,
          ),
        );
      }

      options.headers["Authorization"] = accessToken;
    } else {
      options.headers.remove("Authorization");
    }
    
    // A partir do Dio versão 4 é preciso declarar para o Dio continuar
    handler.next(options);
  }

  // Antes de devolver para quem chamou
  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   super.onError(err, handler);
  // }
}
