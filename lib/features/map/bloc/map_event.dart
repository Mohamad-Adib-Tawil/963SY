part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class MapStarted extends MapEvent {}

class MapLocationUpdated extends MapEvent {
  final double latitude;
  final double longitude;

  const MapLocationUpdated({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class MapMarkerAdded extends MapEvent {
  final double latitude;
  final double longitude;
  final String title;

  const MapMarkerAdded({
    required this.latitude,
    required this.longitude,
    required this.title,
  });

  @override
  List<Object?> get props => [latitude, longitude, title];
}

class MapMarkerRemoved extends MapEvent {
  final String markerId;

  const MapMarkerRemoved(this.markerId);

  @override
  List<Object?> get props => [markerId];
}
