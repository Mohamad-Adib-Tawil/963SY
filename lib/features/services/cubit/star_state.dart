part of 'star_cubit.dart';

sealed class StarState extends Equatable {
  const StarState();

  @override
  List<Object> get props => [];
}

final class StarInitial extends StarState {}
final class StarLoading extends StarState {}
final class StarsSuccess extends StarState {
  final List<StarModel> stars;

  const StarsSuccess({required this.stars});
}
final class StarFailuer extends StarState {
  final String errorMessage;

  const StarFailuer({required this.errorMessage});
}
