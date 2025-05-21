import 'dart:convert';

class Service {
  int? id;
  String? serName;
  int? serType;
  String? serPhoto;
  String? description;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  DateTime? createdAt;
  DateTime? updatedAt;

  Service({
    this.id,
    this.serName,
    this.serType,
    this.serPhoto,
    this.description,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.createdAt,
    this.updatedAt,
  });

  factory Service.fromMap(Map<String, dynamic> data) => Service(
        id: data['id'] as int?,
        serName: data['ser_name'] as String?,
        serType: data['ser_type'] as int?,
        serPhoto: data['ser_photo'] as String?,
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
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'ser_name': serName,
        'ser_type': serType,
        'ser_photo': serPhoto,
        'description': description,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Service].
  factory Service.fromJson(String data) {
    return Service.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Service] to a JSON string.
  String toJson() => json.encode(toMap());
}
