class Place {
  final int id;
  final String placeName;
  final int placeType;
  final String photo;
  final String description;
  final int languagesIdlanguages;
  final int categoriesIdcategories;
  final int citiesIdcities;
  final String createdAt;
  final String updatedAt;

  Place({
    required this.id,
    required this.placeName,
    required this.placeType,
    required this.photo,
    required this.description,
    required this.languagesIdlanguages,
    required this.categoriesIdcategories,
    required this.citiesIdcities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      placeName: json['place_name'],
      placeType: json['place_type'],
      photo: json['photo'],
      description: json['description'],
      languagesIdlanguages: json['languages_idlanguages'],
      categoriesIdcategories: json['categories_idcategories'],
      citiesIdcities: json['cities_idcities'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
