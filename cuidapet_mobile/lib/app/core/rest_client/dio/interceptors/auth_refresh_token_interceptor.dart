import 'package:cuidapet_mobile/app/core/exceptions/expire_token_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_excepiton.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class AuthRefreshTokenInterceptor extends Interceptor {

  final AuthStore _authStore;
  final ILocalStorage _localStorage;
  final ILocalSecureStorage _localSecureStorage;
  final IRestClient _restClient;
  final IAppLogger _logger;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required ILocalStorage localStorage,
    required ILocalSecureStorage localSecureStorage,
    required IRestClient restClient,
    required IAppLogger logger,
  }) : _authStore = authStore,
       _localStorage = localStorage,
       _localSecureStorage = localSecureStorage,
       _restClient = restClient,
       _logger = logger;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    
    try {
      final respStatusCode = err.response?.statusCode ?? 0;
      
      final reqPath = err.requestOptions.path;
      
      // Se for erro relacionado a Autorização / Proibido
      if(respStatusCode == 403 || respStatusCode == 401) {

        // Caso não seja um erro no endpoint de Refresh Token, eu prossigo com a segunda tentativa
        // de chamada do Refresh Token e do endpoint que foi chamado que deu não autorizado
        if(reqPath != '/auth/refresh') {

          final authRequired = err.requestOptions.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

          if(authRequired) {
            _logger.append("############### REFRESH TOKEN ###############");

            // Fazendo a chamada para o endpoint de Refresh Token para ter acesso
            // a um novo AccessToken e RefreshToken
            await _refreshToken();

            // Uma nova tentativa de chamar o método
            await _retryRequest(err, handler);

          } else {
            throw err;
          }
          
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on ExpireTokenException {
      _authStore.logout();

      handler.next(err);
    } on DioError catch (e) {
      handler.next(e);
    } catch(e,s) {
      _logger.error("Error rest client", e, s);
      handler.next(err);
    } finally {
      _logger.closeAppend();
    }
  }
  
  Future<void> _refreshToken() async {

    try {
      final refreshToken = await _localSecureStorage.read(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY);
      
      if(refreshToken == null) {
        throw ExpireTokenException();
      }
      
      final resultRefresh = await _restClient.auth().put("/auth/refresh", data: {
        'refresh_token': refreshToken,
      });
      
      await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, 
        resultRefresh.data["access_token"],
      );
      
      await _localSecureStorage.write(
        Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY, 
        resultRefresh.data["refresh_token"],
      );
    } on RestClientExcepiton catch(e, s) {
      _logger.error("Erro ao tentar fazer o refresh token", e, s);
      throw ExpireTokenException();
    }
  }
  
  Future<void> _retryRequest(DioError err, ErrorInterceptorHandler handler) async {

    _logger.append("############### RETRY REQUEST ###############");

    final requestOptions = err.requestOptions;

    final result = await _restClient.request(
      requestOptions.path, 
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
  

}
