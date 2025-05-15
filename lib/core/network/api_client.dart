import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'dart:developer' as developer;

class ApiClient {
  late final Dio _dio;
  static ApiClient? _instance;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);

    // Add connection error handling
    _dio.options.validateStatus = (status) {
      return status != null && status < 500;
    };
  }

  static ApiClient get instance {
    _instance ??= ApiClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      developer.log('Making GET request to: ${ApiEndpoints.baseUrl}$path');
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      developer.log('DioException in GET request', error: e);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Connection timeout. Please check your internet connection and try again.',
          type: e.type,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Could not connect to the server. Please check if the server is running and try again.',
          type: e.type,
        );
      }
      rethrow;
    } catch (e) {
      developer.log('Unexpected error in GET request', error: e);
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      developer.log('Making POST request to: ${ApiEndpoints.baseUrl}$path');
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      developer.log('DioException in POST request', error: e);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Connection timeout. Please check your internet connection and try again.',
          type: e.type,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Could not connect to the server. Please check if the server is running and try again.',
          type: e.type,
        );
      }
      rethrow;
    } catch (e) {
      developer.log('Unexpected error in POST request', error: e);
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      developer.log('Making PUT request to: ${ApiEndpoints.baseUrl}$path');
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      developer.log('DioException in PUT request', error: e);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Connection timeout. Please check your internet connection and try again.',
          type: e.type,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Could not connect to the server. Please check if the server is running and try again.',
          type: e.type,
        );
      }
      rethrow;
    } catch (e) {
      developer.log('Unexpected error in PUT request', error: e);
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      developer.log('Making DELETE request to: ${ApiEndpoints.baseUrl}$path');
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      developer.log('DioException in DELETE request', error: e);
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Connection timeout. Please check your internet connection and try again.',
          type: e.type,
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw DioException(
          requestOptions: e.requestOptions,
          error:
              'Could not connect to the server. Please check if the server is running and try again.',
          type: e.type,
        );
      }
      rethrow;
    } catch (e) {
      developer.log('Unexpected error in DELETE request', error: e);
      rethrow;
    }
  }
}
