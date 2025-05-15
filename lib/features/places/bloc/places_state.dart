part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Governorate> governorates;
  final String tourismType;
  final int defaultIndex;

  const PlacesLoaded({
    required this.governorates,
    required this.tourismType,
    required this.defaultIndex,
  });

  @override
  List<Object> get props => [governorates, tourismType, defaultIndex];
}

class PlaceDetailsLoaded extends PlacesState {
  final TouristPlace place;

  const PlaceDetailsLoaded({required this.place});

  @override
  List<Object> get props => [place];
}

class PlacesError extends PlacesState {
  final String message;

  const PlacesError(this.message);

  @override
  List<Object> get props => [message];
}
