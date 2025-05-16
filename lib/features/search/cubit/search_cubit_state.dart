part of 'search_cubit_cubit.dart';

sealed class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object> get props => [];
}

final class SearchCubitInitial extends SearchCubitState {}
final class SearchCubitLoding extends SearchCubitState {}
final class SearchCubitSuccess extends SearchCubitState {
  final List<Place> places;
  const SearchCubitSuccess(this.places);
}
final class SearchCubitError extends SearchCubitState {
  final String message;
  const SearchCubitError(this.message);
}
