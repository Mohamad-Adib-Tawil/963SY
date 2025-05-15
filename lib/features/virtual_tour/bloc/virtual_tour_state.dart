part of 'virtual_tour_bloc.dart';

abstract class VirtualTourState extends Equatable {
  const VirtualTourState();

  @override
  List<Object> get props => [];
}

class VirtualTourInitial extends VirtualTourState {}

class VirtualTourLoading extends VirtualTourState {}

class VirtualTourLoaded extends VirtualTourState {
  final String tourUrl;
  final String placeName;

  const VirtualTourLoaded({
    required this.tourUrl,
    required this.placeName,
  });

  @override
  List<Object> get props => [tourUrl, placeName];
}

class VirtualTourError extends VirtualTourState {
  final String message;

  const VirtualTourError(this.message);

  @override
  List<Object> get props => [message];
}
