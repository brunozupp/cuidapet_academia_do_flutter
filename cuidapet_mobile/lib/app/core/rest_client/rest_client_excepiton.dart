import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';

class RestClientExcepiton implements Exception {
  
  String? message;
  int? statusCode;
  dynamic error;
  RestClientResponse response;
  
  RestClientExcepiton({
    this.message,
    this.statusCode,
    required this.error,
    required this.response,
  });

  @override
  String toString() {
    return 'RestClientExcepiton(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
