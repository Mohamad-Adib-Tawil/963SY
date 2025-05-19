import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled4/core/constants/language_id.dart';
import 'package:untitled4/core/errors/failuer.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/models/link.dart';
import 'package:untitled4/models/media.dart';

class PlaceDetailsRepo {
  final ApiService apiService;

  PlaceDetailsRepo({required this.apiService});

  Future<Either<Failuer, List<Media>>> getMedia(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    try {
      int lang = await getLanguageId();
      var response = await apiService.get(
          endPoints:
              '/media1/media/place/$placeId/city/$cityId/category/$categoryId/language/$lang');
      log(response.toString());
      List<dynamic> data = response['data'];
      final medias = data.map((json) => Media.fromMap(json)).toList();
      log('#Media: response with data : ${medias.toList()}');
      return Right(medias);
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.toString()}');
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      log('error: ${e.toString()}');
      return Left(ServerFailuer(e.toString()));
    }
  }

  Future<Either<Failuer, List<Link>>> getLinks(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    try {
      int lang = await getLanguageId();
      var response = await apiService.get(
          endPoints:
              '/link1/links/place/$placeId/city/$cityId/category/$categoryId/language/$lang');
      log(response.toString());
      List<dynamic> data = response['data'];
      final links = data.map((json) => Link.fromMap(json)).toList();
      log('#Links: response with data : ${links.toList()}');
      return Right(links);
    } catch (e) {
      if (e is DioException) {
        log('Dio error: ${e.toString()}');
        return Left(ServerFailuer.fromDioExceptio(e));
      }
      log('error: ${e.toString()}');
      return Left(ServerFailuer(e.toString()));
    }
  }
}
