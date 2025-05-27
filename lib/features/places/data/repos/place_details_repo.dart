import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled4/core/constants/language_id.dart';
import 'package:untitled4/core/errors/failuer.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/features/places/data/models/coordinates.dart';
import 'package:untitled4/features/places/data/models/place_details_model.dart';
import 'package:untitled4/models/link.dart';
import 'package:untitled4/models/media.dart';

class PlaceDetailsRepo {
  final ApiService apiService;

  PlaceDetailsRepo({required this.apiService});

  Future<Either<Failuer, PlaceDetailsModel>> getDetails(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    try {
      // get the language ID
      int lang = await getLanguageId();

      //get the media and store it in medias
      var responseMedia = await apiService.get(
          endPoints:
              '/media1/media/place/$placeId/city/$cityId/category/$categoryId/language/$lang');
      List<dynamic> dataMedia =
          responseMedia['data'].isEmpty ? [] : responseMedia['data'];
      List<Media> medias;
      if (dataMedia.isEmpty) {
        medias = [];
      } else {
        medias = dataMedia.map((json) => Media.fromMap(json)).toList();
      }

      //get the links and store it in links
      var responseLinks = await apiService.get(
          endPoints:
              '/link1/links/place/$placeId/city/$cityId/category/$categoryId/language/$lang');
      List<dynamic> dataLinks =
          responseLinks['data'].isEmpty ? [] : responseLinks['data'];
      List<Link> links;
      if (dataLinks.isEmpty) {
        links = [];
      } else {
        links = dataLinks.map((json) => Link.fromMap(json)).toList();
      }

      //get the way and store it in coordinates
      var responseWay = await apiService.get(
          endPoints:
              '/way1/ways/place/$placeId/city/$cityId/category/$categoryId/language/$lang');
      dynamic dataWay =
          responseWay['data'].isEmpty ? {} : responseWay['data'][0];
      log('-----RESPONSE OF WAY:${dataWay.toString()} Langage:$lang');
      Coordinates coordinates;
      if (dataWay.isEmpty) {
        coordinates = Coordinates(vertical: '0', horizontal: '0');
      } else {
        coordinates = Coordinates.fromMap(dataWay);
      }

      //return the place details model
      return Right(PlaceDetailsModel(
          media: medias, links: links, coordinates: coordinates));
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
