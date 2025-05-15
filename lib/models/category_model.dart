class Category {
  final int id;
  final String catName;
  final int catType;
  final int languagesIdlanguages;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.catName,
    required this.catType,
    required this.languagesIdlanguages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      catName: json['cat_name'],
      catType: json['cat_type'],
      languagesIdlanguages: json['languages_idlanguages'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
