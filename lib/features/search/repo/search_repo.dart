import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled4/core/errors/failuer.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/models/place_model.dart';

class SearchRepo {
  final ApiService apiService;
  SearchRepo({required this.apiService});

  Future<Either<Failuer, List<Place>>> search(String query) async {
    try {
      var response = await apiService.post(
          endPoints: '/place1/search', data: FormData.fromMap({'name': query}));
      List<dynamic> data = response['data'];
      final places = data.map((json) => Place.fromJson(json)).toList();
      log('---Cubit:${data.toString()}');
      return Right(places);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }
}
