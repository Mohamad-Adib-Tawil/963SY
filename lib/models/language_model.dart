class Language {
  final int id;
  final String name;
  final String code;
  final int type;
  final String createdAt;
  final String updatedAt;

  Language({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
