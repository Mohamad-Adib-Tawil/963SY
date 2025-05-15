import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        err = DioException(
          requestOptions: err.requestOptions,
          error: 'Connection timeout. Please check your internet connection.',
          type: err.type,
        );
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            err = DioException(
              requestOptions: err.requestOptions,
              error: 'Bad request. Please check your input.',
              type: err.type,
              response: err.response,
            );
            break;
          case 401:
            err = DioException(
              requestOptions: err.requestOptions,
              error: 'Unauthorized. Please login again.',
              type: err.type,
              response: err.response,
            );
            break;
          case 403:
            err = DioException(
              requestOptions: err.requestOptions,
              error:
                  'Forbidden. You don\'t have permission to access this resource.',
              type: err.type,
              response: err.response,
            );
            break;
          case 404:
            err = DioException(
              requestOptions: err.requestOptions,
              error: 'Resource not found.',
              type: err.type,
              response: err.response,
            );
            break;
          case 500:
            err = DioException(
              requestOptions: err.requestOptions,
              error: 'Internal server error. Please try again later.',
              type: err.type,
              response: err.response,
            );
            break;
          default:
            err = DioException(
              requestOptions: err.requestOptions,
              error: 'Something went wrong. Please try again.',
              type: err.type,
              response: err.response,
            );
        }
        break;
      case DioExceptionType.cancel:
        err = DioException(
          requestOptions: err.requestOptions,
          error: 'Request cancelled.',
          type: err.type,
        );
        break;
      case DioExceptionType.unknown:
        err = DioException(
          requestOptions: err.requestOptions,
          error:
              'Unknown error occurred. Please check your internet connection.',
          type: err.type,
        );
        break;
      default:
        err = DioException(
          requestOptions: err.requestOptions,
          error: 'Something went wrong. Please try again.',
          type: err.type,
        );
    }
    return handler.next(err);
  }
}
