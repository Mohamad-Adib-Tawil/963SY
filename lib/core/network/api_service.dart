import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  final _baseURL = 'https://963sy.net/back/api/user';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get(
      {required String endPoints, var data}) async {
    var response = await _dio.get('$_baseURL$endPoints', queryParameters: data);
    log('$_baseURL$endPoints');
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoints, var data}) async {
    var response = await _dio.post('$_baseURL$endPoints', data: data);
    return response.data;
  }
}
