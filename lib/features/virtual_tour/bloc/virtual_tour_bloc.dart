import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/features/places/data/models/governorates_data.dart';

part 'virtual_tour_event.dart';
part 'virtual_tour_state.dart';

class VirtualTourBloc extends Bloc<VirtualTourEvent, VirtualTourState> {
  VirtualTourBloc() : super(VirtualTourInitial()) {
    on<LoadVirtualTour>(_onLoadVirtualTour);
    on<StartVirtualTour>(_onStartVirtualTour);
  }

  void _onLoadVirtualTour(
      LoadVirtualTour event, Emitter<VirtualTourState> emit) async {
    try {
      emit(VirtualTourLoading());

      // TODO: Replace with actual API call
      // For now, we'll use static data
      const governorates = GovernoratesData.governorates;
      TouristPlace? place;

      for (final governorate in governorates) {
        try {
          place = governorate.places.firstWhere(
            (p) => p.name == event.placeId,
          );
          break;
        } catch (_) {
          continue;
        }
      }

      if (place != null) {
        // TODO: Replace with actual virtual tour URL
        const tourUrl = 'https://example.com/virtual-tour';
        emit(VirtualTourLoaded(
          tourUrl: tourUrl,
          placeName: place.name,
        ));
      } else {
        emit(const VirtualTourError('Place not found'));
      }
    } catch (e) {
      emit(VirtualTourError(e.toString()));
    }
  }

  void _onStartVirtualTour(
      StartVirtualTour event, Emitter<VirtualTourState> emit) {
    if (state is VirtualTourLoaded) {
      final currentState = state as VirtualTourLoaded;
      // TODO: Implement virtual tour start logic
      // For now, we'll just emit the same state
      emit(currentState);
    }
  }
}
