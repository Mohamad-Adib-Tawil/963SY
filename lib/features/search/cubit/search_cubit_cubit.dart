import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/search/repo/search_repo.dart';
import 'package:untitled4/models/place_model.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit(this.searchRepo) : super(SearchCubitInitial());
  final SearchRepo searchRepo;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchCubitInitial()); // reset if field is cleared
      return;
    }

    emit(SearchCubitLoding());
    final result = await searchRepo.search(query);
    result.fold(
      (failure) => emit(SearchCubitError(failure.errorMessage)),
      (places) => emit(SearchCubitSuccess(places)),
    );
  }
}
