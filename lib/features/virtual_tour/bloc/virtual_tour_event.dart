part of 'virtual_tour_bloc.dart';

abstract class VirtualTourEvent extends Equatable {
  const VirtualTourEvent();

  @override
  List<Object> get props => [];
}

class LoadVirtualTour extends VirtualTourEvent {
  final String placeId;

  const LoadVirtualTour({required this.placeId});

  @override
  List<Object> get props => [placeId];
}

class StartVirtualTour extends VirtualTourEvent {
  const StartVirtualTour();

  @override
  List<Object> get props => [];
}
