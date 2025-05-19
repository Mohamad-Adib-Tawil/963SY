import 'dart:convert';

class Media {
  int? id;
  String? medName;
  int? medType;
  String? medContent;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  int? placesIdplaces;
  DateTime? createdAt;
  DateTime? updatedAt;

  Media({
    this.id,
    this.medName,
    this.medType,
    this.medContent,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.placesIdplaces,
    this.createdAt,
    this.updatedAt,
  });

  factory Media.fromMap(Map<String, dynamic> data) => Media(
        id: data['id'] as int?,
        medName: data['med_name'] as String?,
        medType: data['med_type'] as int?,
        medContent: data['med_content'] as String?,
        languagesIdlanguages: data['languages_idlanguages'] as int?,
        categoriesIdcategories: data['categories_idcategories'] as int?,
        citiesIdcities: data['cities_idcities'] as int?,
        placesIdplaces: data['places_idplaces'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'med_name': medName,
        'med_type': medType,
        'med_content': medContent,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'places_idplaces': placesIdplaces,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Media].
  factory Media.fromJson(String data) {
    return Media.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Media] to a JSON string.
  String toJson() => json.encode(toMap());
}
