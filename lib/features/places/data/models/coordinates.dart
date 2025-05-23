import 'dart:convert';

class Coordinates {
  int? id;
  String? name;
  int? wayType;
  String? horizontal;
  String? vertical;
  String? address;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  int? placesIdplaces;
  DateTime? createdAt;
  DateTime? updatedAt;

  Coordinates({
    this.id,
    this.name,
    this.wayType,
    this.horizontal,
    this.vertical,
    this.address,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.placesIdplaces,
    this.createdAt,
    this.updatedAt,
  });

  factory Coordinates.fromMap(Map<String, dynamic> data) => Coordinates(
        id: data['id'] as int?,
        name: data['name'] as String?,
        wayType: data['way_type'] as int?,
        horizontal: data['horizontal'] as String?,
        vertical: data['vertical'] as String?,
        address: data['address'] as String?,
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
        'name': name,
        'way_type': wayType,
        'horizontal': horizontal,
        'vertical': vertical,
        'address': address,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'places_idplaces': placesIdplaces,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Coordinates].
  factory Coordinates.fromJson(String data) {
    return Coordinates.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Coordinates] to a JSON string.
  String toJson() => json.encode(toMap());
}
