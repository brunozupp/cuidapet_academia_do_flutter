import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';

abstract class IRestClient {
  
  IRestClient auth();
  IRestClient unauth();

  Future<RestClientResponse<T>> post<T>(
    String path, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );

  Future<RestClientResponse<T>> get<T>(
    String path, {
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );

  Future<RestClientResponse<T>> put<T>(
    String path, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );

  Future<RestClientResponse<T>> delete<T>(
    String path, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );

  Future<RestClientResponse<T>> patch<T>(
    String path, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );

  // Esse cara pode ser qualquer um dos outros acima, usando o method
  Future<RestClientResponse<T>> request<T>(
    String path, {
      required String method,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
    }
  );
}