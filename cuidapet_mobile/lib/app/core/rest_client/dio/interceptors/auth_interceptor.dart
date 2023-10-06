import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {

  final ILocalStorage _localStorage;
  final AuthStore _authStore;

  AuthInterceptor({
    required ILocalStorage localStorage,
    required AuthStore authStore,
  }) : _localStorage = localStorage,
       _authStore = authStore;
  
  // Antes de enviar para o servidor
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    
    final authRequired = options.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

    if(authRequired) {

      final accessToken = await _localStorage.read(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY);

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
}
