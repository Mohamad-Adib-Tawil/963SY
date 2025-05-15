import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/features/places/data/models/governorates_data.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) {
    if (event.query.isEmpty) {
      emit(SearchInitial());
    } else {
      emit(SearchLoading());
      _performSearch(event.query, emit);
    }
  }

  void _onSearchSubmitted(SearchSubmitted event, Emitter<SearchState> emit) {
    emit(SearchLoading());
    _performSearch(event.query, emit);
  }

  void _performSearch(String query, Emitter<SearchState> emit) {
    try {
      // const governorates = GovernoratesData.governorates;
      final results = <dynamic>[];
      final languageCode = 'ar'; // or get from context/provider if available

      // Search in governorates
      //   for (final governorate in governorates) {
      //     if ((governorate.name[languageCode] ?? governorate.name.values.first)
      //         .toLowerCase()
      //         .contains(query.toLowerCase())) {
      //       results.add(governorate);
      //     }

      //     // Search in places
      //     for (final place in governorate.places) {
      //       if ((place.name[languageCode] ?? place.name.values.first)
      //               .toLowerCase()
      //               .contains(query.toLowerCase()) ||
      //           (place.description[languageCode] ??
      //                   place.description.values.first)
      //               .toLowerCase()
      //               .contains(query.toLowerCase())) {
      //         results.add(place);
      //       }
      //     }
      //   }

      emit(SearchResultsLoaded(results: results, query: query));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
