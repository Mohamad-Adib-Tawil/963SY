part of 'places_cubit_cubit.dart';

sealed class PlacesCubitState extends Equatable {
  const PlacesCubitState();

  @override
  List<Object> get props => [];
}

final class PlacesCubitInitial extends PlacesCubitState {}

final class PlacesCubitLoading extends PlacesCubitState {}

final class PlacesCubitSuccess extends PlacesCubitState {
  final List<Place> places;
  const PlacesCubitSuccess(this.places);
}

final class PlacesCubitFailuer extends PlacesCubitState {
  final String errorMessage;
  const PlacesCubitFailuer(this.errorMessage);
}
