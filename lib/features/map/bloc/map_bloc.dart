import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    on<MapStarted>(_onMapStarted);
    on<MapLocationUpdated>(_onLocationUpdated);
    on<MapMarkerAdded>(_onMarkerAdded);
    on<MapMarkerRemoved>(_onMarkerRemoved);
  }

  void _onMapStarted(MapStarted event, Emitter<MapState> emit) {
    emit(MapLoading());
    // Initialize with default location (you can change this)
    emit(const MapLoaded(
      currentLatitude: 0.0,
      currentLongitude: 0.0,
    ));
  }

  void _onLocationUpdated(MapLocationUpdated event, Emitter<MapState> emit) {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      emit(MapLoaded(
        currentLatitude: event.latitude,
        currentLongitude: event.longitude,
        markers: currentState.markers,
      ));
    }
  }

  void _onMarkerAdded(MapMarkerAdded event, Emitter<MapState> emit) {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      final newMarker = MapMarker(
        id: const Uuid().v4(),
        latitude: event.latitude,
        longitude: event.longitude,
        title: event.title,
      );
      emit(MapLoaded(
        currentLatitude: currentState.currentLatitude,
        currentLongitude: currentState.currentLongitude,
        markers: [...currentState.markers, newMarker],
      ));
    }
  }

  void _onMarkerRemoved(MapMarkerRemoved event, Emitter<MapState> emit) {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      emit(MapLoaded(
        currentLatitude: currentState.currentLatitude,
        currentLongitude: currentState.currentLongitude,
        markers: currentState.markers
            .where((marker) => marker.id != event.markerId)
            .toList(),
      ));
    }
  }
}
