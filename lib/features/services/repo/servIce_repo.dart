import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled4/core/constants/language_id.dart';
import 'package:untitled4/core/errors/failuer.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/features/places/data/models/city_model.dart';
import 'package:untitled4/features/services/model/place_of_service/place_of_service.dart';
import 'package:untitled4/features/services/model/star_model.dart';
import 'package:untitled4/models/service.dart';

class ServiceRepo {
  final ApiService apiService;

  ServiceRepo({required this.apiService});

  Future<Either<Failuer, List<CityModel>>> getServiceCities(
      {required int categoryId}) async {
    int lang = await getLanguageId();
    try {
      var response = await apiService.get(
          endPoints: '/city1/cities/category/$categoryId/language/$lang');
      List<dynamic> data = response['data'];
      final cities = data.map((json) => CityModel.fromMap(json)).toList();
      log('-----RESPONSE OF CITY:${data.toString()} Langage:$lang');
      return Right(cities);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }

  Future<Either<Failuer, List<Service>>> getCityServices(
      {required int cityID, required int categoryId}) async {
    int lang = await getLanguageId();
    try {
      var response = await apiService.get(
          endPoints:
              '/service1/services/city/$cityID/category/$categoryId/language/$lang');
      List<dynamic> data = response['data'];
      final services = data.map((json) => Service.fromMap(json)).toList();
      log('-----RESPONSE OF SERVICE:${data.toString()} Langage:$lang');
      return Right(services);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }

  Future<Either<Failuer, List<PlaceOfService>>> getPlaceOfService(
      {required int serviceId,
      required int cityId,
      required categoryId}) async {
    int lang = await getLanguageId();
    try {
      var response = await apiService.get(
          endPoints:
              '/place1/places/city/$cityId/category/$categoryId/language/$lang/service/$serviceId');
      List<dynamic> data = response['data'];
      final places = data.map((json) => PlaceOfService.fromMap(json)).toList();
      log('-----RESPONSE OF SERVICE:${data.toString()} Langage:$lang');
      return Right(places);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }

  Future<Either<Failuer, List<StarModel>>> getServiceStars(
      {required int serviceId,
      required int cityId,
      required categoryId}) async {
    int lang = await getLanguageId();
    try {
      var response = await apiService.get(
          endPoints: '/star1/star/category/$categoryId/language/$lang/service/$serviceId/city/$cityId');
      List<dynamic> data = response['data'];
      final stars = data.map((json) => StarModel.fromMap(json)).toList();
      log('-----RESPONSE OF SERVICE:${data.toString()} Langage:$lang');
      return Right(stars);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }
  Future<Either<Failuer, List<PlaceOfService>>> getPlaceOfServiceByStar({required int serviceId,
      required int cityId,
      required categoryId,
      required starId}) async{
    int lang = await getLanguageId();
    try {
      var response = await apiService.get(
          endPoints: '/place1/places/city/$cityId/category/$categoryId/language/$lang/service/$serviceId/star/$starId');
      List<dynamic> data = response['data'];
      final places = data.map((json) => PlaceOfService.fromMap(json)).toList();
      log('-----RESPONSE OF SERVICE:${data.toString()} Langage:$lang');
      return Right(places);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioExceptio(e));
      }
      return Left(ServerFailuer(e.toString()));
    }
  }
}
