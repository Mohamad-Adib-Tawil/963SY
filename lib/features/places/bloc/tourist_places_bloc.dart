import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'tourist_places_event.dart';
part 'tourist_places_state.dart';

class TouristPlacesBloc extends Bloc<TouristPlacesEvent, TouristPlacesState> {
  TouristPlacesBloc() : super(TouristPlacesInitial());
}
