import 'dart:convert';

class City {
  int? id;
  String? cityName;
  int? cityType;
  String? photo;
  String? description;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  DateTime? createdAt;
  DateTime? updatedAt;

  City({
    this.id,
    this.cityName,
    this.cityType,
    this.photo,
    this.description,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromMap(Map<String, dynamic> data) => City(
        id: data['id'] as int?,
        cityName: data['city_name'] as String?,
        cityType: data['city_type'] as int?,
        photo: data['photo'] as String?,
        description: data['description'] as String?,
        languagesIdlanguages: data['languages_idlanguages'] as int?,
        categoriesIdcategories: data['categories_idcategories'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'city_name': cityName,
        'city_type': cityType,
        'photo': photo,
        'description': description,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [City].
  factory City.fromJson(String data) {
    return City.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [City] to a JSON string.
  String toJson() => json.encode(toMap());
}
