part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();

  @override
  List<Object> get props => [];
}

class LoadPlaces extends PlacesEvent {
  final String tourismType;
  final int languageId;
  final int categoryId;

  const LoadPlaces(
      {required this.tourismType,
      required this.languageId,
      required this.categoryId});

  @override
  List<Object> get props => [tourismType, languageId, categoryId];
}

class LoadPlaceDetails extends PlacesEvent {
  final String placeId;

  const LoadPlaceDetails({required this.placeId});

  @override
  List<Object> get props => [placeId];
}
