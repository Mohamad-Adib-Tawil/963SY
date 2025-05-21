part of 'place_details_cubit.dart';

sealed class PlaceDetailsState extends Equatable {
  const PlaceDetailsState();

  @override
  List<Object> get props => [];
}

final class PlaceDetailsInitial extends PlaceDetailsState {}

final class PlaceDetailsLoading extends PlaceDetailsState {}

final class PlaceDetailsSuccess extends PlaceDetailsState {
  final PlaceDetailsModel placeDetailsModel;

  const PlaceDetailsSuccess({required this.placeDetailsModel});
}

final class PlaceDetailsError extends PlaceDetailsState {
  final String errorMessage;

  const PlaceDetailsError({required this.errorMessage});
}
