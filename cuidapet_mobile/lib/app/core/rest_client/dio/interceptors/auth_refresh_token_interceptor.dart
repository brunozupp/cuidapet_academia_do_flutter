import 'package:cuidapet_mobile/app/core/exceptions/expire_token_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
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
      
      if(respStatusCode == 403 || respStatusCode == 401) {
        if(reqPath != '/auth/refresh') {

          final authRequired = err.requestOptions.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

          if(authRequired) {
            _logger.append("############### REFRESH TOKEN ###############");

            await _refreshToken(err);

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
  
  Future<void> _refreshToken(DioError err) async {

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
