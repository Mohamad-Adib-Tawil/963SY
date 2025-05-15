import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/features/places/data/models/governorates_data.dart';
import 'package:untitled4/core/network/api_client.dart';
import 'dart:developer' as developer;

part 'places_event.dart';
part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  PlacesBloc() : super(PlacesInitial()) {
    on<LoadPlaces>(_onLoadPlaces);
    on<LoadPlaceDetails>(_onLoadPlaceDetails);
  }

  void _onLoadPlaces(LoadPlaces event, Emitter<PlacesState> emit) async {
    try {
      emit(PlacesLoading());

      // Fetch cities from API using languageId and categoryId
      final response = await ApiClient.instance.get(
        '/city1/cities/category/${event.categoryId}/language/${event.languageId}',
      );
      developer.log(
          'Cities API response: \\nStatus: \\${response.statusCode}\\nData: \\${response.data}');

      // Map the response to the required model for the UI
      final List<dynamic> data = response.data['data'] ?? [];
      final List<Governorate> governorates = data.map((json) {
        return Governorate(
          name: json['city_name'] ?? '',
          description: json['description'] ?? '',
          image: json['photo'] ?? '',
          places: const [], // You can fill this if your API provides places
        );
      }).toList();

      emit(PlacesLoaded(
        governorates: governorates,
        tourismType: event.tourismType,
        defaultIndex: 0,
      ));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }

  void _onLoadPlaceDetails(
      LoadPlaceDetails event, Emitter<PlacesState> emit) async {
    try {
      emit(PlacesLoading());

      // TODO: Replace with actual API call
      // For now, we'll use the static data
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
        emit(PlaceDetailsLoaded(place: place));
      } else {
        emit(const PlacesError('Place not found'));
      }
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }
}
