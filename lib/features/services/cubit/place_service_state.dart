part of 'place_service_cubit.dart';

sealed class PlaceServiceState extends Equatable {
  const PlaceServiceState();

  @override
  List<Object> get props => [];
}

final class PlaceServiceInitial extends PlaceServiceState {}
final class PlaceServiceLoading extends PlaceServiceState {}
final class PlaceServiceSuccess extends PlaceServiceState {
  final List<PlaceOfService> placeOfServices;

  const PlaceServiceSuccess({required this.placeOfServices});
}
final class PlaceServiceFailuer extends PlaceServiceState {
  final String errorMessage;

  const PlaceServiceFailuer({required this.errorMessage});

}
