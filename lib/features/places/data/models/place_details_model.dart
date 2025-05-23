import 'package:untitled4/features/places/data/models/coordinates.dart';
import 'package:untitled4/models/link.dart';
import 'package:untitled4/models/media.dart';

class PlaceDetailsModel {
  final List<Media> media;
  final List<Link> links;
  final Coordinates coordinates;

  PlaceDetailsModel(
      {required this.media, required this.links, required this.coordinates});
}
