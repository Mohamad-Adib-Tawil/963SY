part of 'tourist_places_bloc.dart';

abstract class TouristPlacesState extends Equatable {
  const TouristPlacesState();

  @override
  List<Object?> get props => [];
}

class TouristPlacesInitial extends TouristPlacesState {}

class TouristPlacesLoaded extends TouristPlacesState {
  // Add any properties you want to load here
  const TouristPlacesLoaded();
}
