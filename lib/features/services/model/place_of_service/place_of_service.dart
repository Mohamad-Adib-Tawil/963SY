import 'dart:convert';

import 'service.dart';

class PlaceOfService {
  int? id;
  String? placeName;
  int? placeType;
  String? photo;
  String? description;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic star;
  Service? service;
  String? dateCreated;

  PlaceOfService({
    this.id,
    this.placeName,
    this.placeType,
    this.photo,
    this.description,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.createdAt,
    this.updatedAt,
    this.star,
    this.service,
    this.dateCreated,
  });

  factory PlaceOfService.fromMap(Map<String, dynamic> data) {
    return PlaceOfService(
      id: data['id'] as int?,
      placeName: data['place_name'] as String?,
      placeType: data['place_type'] as int?,
      photo: data['photo'] as String?,
      description: data['description'] as String?,
      languagesIdlanguages: data['languages_idlanguages'] as int?,
      categoriesIdcategories: data['categories_idcategories'] as int?,
      citiesIdcities: data['cities_idcities'] as int?,
      createdAt: data['created_at'] == null
          ? null
          : DateTime.parse(data['created_at'] as String),
      updatedAt: data['updated_at'] == null
          ? null
          : DateTime.parse(data['updated_at'] as String),
      star: data['star'] as dynamic,
      service: data['service'] == null
          ? null
          : Service.fromMap(data['service'] as Map<String, dynamic>),
      dateCreated: data['date_created'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'place_name': placeName,
        'place_type': placeType,
        'photo': photo,
        'description': description,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'star': star,
        'service': service?.toMap(),
        'date_created': dateCreated,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PlaceOfService].
  factory PlaceOfService.fromJson(String data) {
    return PlaceOfService.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PlaceOfService] to a JSON string.
  String toJson() => json.encode(toMap());
}
