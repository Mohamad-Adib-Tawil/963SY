class TouristPlace {
  final String name;
  final String description;
  final String information;
  final List<String> images;
  final String signLanguageVideoUrl;
  final String VideoUrl;
  final double latitude;
  final double longitude;
  final String tourismType;

  const TouristPlace({
    required this.name,
    required this.description,
    required this.information,
    required this.images,
    required this.signLanguageVideoUrl,
    required this.VideoUrl,
    required this.latitude,
    required this.longitude,
    required this.tourismType,
  });

  @override
  String toString() {
    return 'TouristPlace(name: $name, description: $description, information: $information, images: $images, signLanguageVideoUrl: $signLanguageVideoUrl,VideoUrl: $VideoUrl latitude: $latitude, longitude: $longitude, tourismType: $tourismType)';
  }
}

class Governorate {
  final String name;
  final String description;
  final String image;
  final int id;
  final List<TouristPlace> places;

  const Governorate({
    required this.name,
    required this.description,
    required this.image,
    required this.places,
    required this.id,
  });

  @override
  String toString() {
    return 'Governorate(name: $name, description: $description, image: $image, places: $places)';
  }
}
