class CategoryModel {
  final int id;
  final String catName;
  final int catType;
  final String catPhoto;
  final int languagesIdlanguages;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.catName,
    required this.catType,
    required this.catPhoto,
    required this.languagesIdlanguages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      catName: json['cat_name'],
      catType: json['cat_type'],
      catPhoto: json['cat_photo'],
      languagesIdlanguages: json['languages_idlanguages'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
