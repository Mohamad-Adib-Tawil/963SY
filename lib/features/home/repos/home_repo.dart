import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled4/core/constants/language_id.dart';
import 'package:untitled4/core/errors/failuer.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:untitled4/models/place_model.dart';

class HomeRepo {
  final ApiService apiService;
  HomeRepo({required this.apiService});

  Future<Either<Failuer, List<CategoryModel>>> getCategories() async {
    try {
      int lang = await getLanguageId();
      var response =
          await apiService.get(endPoints: '/category1/category/language/$lang');
      List<dynamic> data = response['data'];
      final categories =
          data.map((json) => CategoryModel.fromJson(json)).toList();
      log('---Cubit:${data.toString()} Langage:$lang');
      return Right(categories);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }

  Future<Either<Failuer, List<Place>>> getPlaces(
      {required int categoryId, required int cityId}) async {
    try {
      int lang = await getLanguageId();
      var response = await apiService.get(
          endPoints:
              '/place1/places/city/$cityId/category/$categoryId/language/$lang');
      List<dynamic> data = response['data'];
      final places = data.map((json) => Place.fromJson(json)).toList();
      log('---Cubit:${data.toString()} Langage:$lang');
      return Right(places);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }

  // Future<Either<Failuer, ListCi>
}
