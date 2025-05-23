import 'dart:convert';

class LanguageModel {
  int? id;
  String? name;
  String? code;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  LanguageModel({
    this.id,
    this.name,
    this.code,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory LanguageModel.fromMap(Map<String, dynamic> data) => LanguageModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        code: data['code'] as String?,
        type: data['type'] as int?,
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
        'code': code,
        'type': type,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LanguageModel].
  factory LanguageModel.fromJson(String data) {
    return LanguageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LanguageModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
