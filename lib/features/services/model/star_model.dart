import 'dart:convert';

class StarModel {
  int? id;
  int? starType;
  int? number;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  int? servicesIdservices;
  DateTime? createdAt;
  DateTime? updatedAt;

  StarModel({
    this.id,
    this.starType,
    this.number,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.servicesIdservices,
    this.createdAt,
    this.updatedAt,
  });

  factory StarModel.fromMap(Map<String, dynamic> data) => StarModel(
        id: data['id'] as int?,
        starType: data['star_type'] as int?,
        number: data['number'] as int?,
        languagesIdlanguages: data['languages_idlanguages'] as int?,
        categoriesIdcategories: data['categories_idcategories'] as int?,
        citiesIdcities: data['cities_idcities'] as int?,
        servicesIdservices: data['services_idservices'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'star_type': starType,
        'number': number,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'services_idservices': servicesIdservices,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StarModel].
  factory StarModel.fromJson(String data) {
    return StarModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StarModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
