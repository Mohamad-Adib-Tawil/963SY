part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final double currentLatitude;
  final double currentLongitude;
  final List<MapMarker> markers;

  const MapLoaded({
    required this.currentLatitude,
    required this.currentLongitude,
    this.markers = const [],
  });

  @override
  List<Object?> get props => [currentLatitude, currentLongitude, markers];
}

class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object?> get props => [message];
}

class MapMarker {
  final String id;
  final double latitude;
  final double longitude;
  final String title;

  const MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.title,
  });
}
