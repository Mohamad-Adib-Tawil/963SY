part of 'city_cubit.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CitySuccess extends CityState {
  final List<CityModel> cities;

  const CitySuccess({required this.cities});
}

final class CityFailuer extends CityState {
  final String errorMessage;
  const CityFailuer({required this.errorMessage});
}
