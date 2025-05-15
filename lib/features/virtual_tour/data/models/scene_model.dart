class Scene {
  final String id;
  final String name;
  final String description;
  final String imagePath;
  final List<String> hotspots;
  final Map<String, double> initialView;

  Scene({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.hotspots,
    required this.initialView,
  });

  factory Scene.fromJson(Map<String, dynamic> json) {
    return Scene(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imagePath: json['imagePath'] as String,
      hotspots: List<String>.from(json['hotspots'] as List),
      initialView: Map<String, double>.from(json['initialView'] as Map),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'hotspots': hotspots,
      'initialView': initialView,
    };
  }
}
