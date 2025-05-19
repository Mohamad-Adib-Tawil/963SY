import 'dart:convert';

class Link {
  int? id;
  String? linkName;
  String? linkHttp;
  int? linkType;
  int? languagesIdlanguages;
  int? categoriesIdcategories;
  int? citiesIdcities;
  int? placesIdplaces;
  DateTime? createdAt;
  DateTime? updatedAt;

  Link({
    this.id,
    this.linkName,
    this.linkHttp,
    this.linkType,
    this.languagesIdlanguages,
    this.categoriesIdcategories,
    this.citiesIdcities,
    this.placesIdplaces,
    this.createdAt,
    this.updatedAt,
  });

  factory Link.fromMap(Map<String, dynamic> data) => Link(
        id: data['id'] as int?,
        linkName: data['link_name'] as String?,
        linkHttp: data['link_http'] as String?,
        linkType: data['link_type'] as int?,
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
        'link_name': linkName,
        'link_http': linkHttp,
        'link_type': linkType,
        'languages_idlanguages': languagesIdlanguages,
        'categories_idcategories': categoriesIdcategories,
        'cities_idcities': citiesIdcities,
        'places_idplaces': placesIdplaces,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Link].
  factory Link.fromJson(String data) {
    return Link.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Link] to a JSON string.
  String toJson() => json.encode(toMap());
}
