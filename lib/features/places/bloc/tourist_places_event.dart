part of 'tourist_places_bloc.dart';



abstract class TouristPlacesEvent extends Equatable {
  const TouristPlacesEvent();

  @override
  List<Object?> get props => [];
}

class TouristPlacesStarted extends TouristPlacesEvent {}
