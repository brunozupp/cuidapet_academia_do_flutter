import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_secure_storage/i_local_secure_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/i_app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptors/auth_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptors/auth_refresh_token_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/i_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_excepiton.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class DioRestClient implements IRestClient {

  late final Dio _dio;

  final _defaultOptions = BaseOptions(
    baseUrl: Environments.param(Constants.ENV_BASE_URL_KEY) ?? "",
    connectTimeout: Duration(
      seconds: int.tryParse(Environments.param(Constants.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY) ?? "") ?? 0
    ),
    receiveTimeout: Duration(
      seconds: int.tryParse(Environments.param(Constants.ENV_REST_CLIENT_RECEIVE_TIMEOUT_KEY) ?? "") ?? 0
    ),
  );

  DioRestClient({
    required ILocalSecureStorage localSecureStorage,
    required ILocalStorage localStorage,
    required IAppLogger logger,
    required AuthStore authStore,
    BaseOptions? baseOptions,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);

    // A ordem dos interceptors é importante, então os que dependem de algum outro
    // vem depois. No caso LogInterceptor necessita de AuthInterceptor para
    // conseguir loggar as informações corretamente
    _dio.interceptors.addAll([
      AuthInterceptor(
        localStorage: localStorage,
        authStore: authStore,
      ),
      AuthRefreshTokenInterceptor(
        authStore: authStore, 
        localStorage: localStorage, 
        localSecureStorage: localSecureStorage, 
        restClient: this, 
        logger: logger
      ),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  @override
  IRestClient auth() {
    _defaultOptions.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    return this;
  }

  @override
  IRestClient unauth() {
    _defaultOptions.extra[Constants.ENV_REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {

    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          method: method,
        ),
      );
      
      return _dioResponseConverter(response);
    } on DioError catch (e) {
      _throwRestClientException(e);
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response<dynamic> response) {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  // Never é um tipo de retorno que diz que esse método nunca vai chegar ao final
  // assim, o erro de possível não retorno onde chama esse cara vai sumir
  Never _throwRestClientException(DioError e) {
    final response = e.response;

    throw RestClientExcepiton(
      error: e.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),

    );
  }
  
}