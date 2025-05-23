part of 'slider_cubit.dart';

sealed class SliderState extends Equatable {
  const SliderState();

  @override
  List<Object> get props => [];
}

final class SliderInitial extends SliderState {}

final class SliderLoading extends SliderState {}

final class SliderSuccess extends SliderState {
  final List<Place> sliderItems;

  const SliderSuccess({required this.sliderItems});
}

final class SliderFailuer extends SliderState {
  final String errorMessage;

  const SliderFailuer({required this.errorMessage});
}
