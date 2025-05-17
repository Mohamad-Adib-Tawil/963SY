import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/place_model.dart';

part 'places_cubit_state.dart';

class PlacesCubitCubit extends Cubit<PlacesCubitState> {
  PlacesCubitCubit(this.HomeRepo) : super(PlacesCubitInitial());
  final HomeRepo;

  Future<void> getPlaces(int categoryId, int cityId) async {
    emit(PlacesCubitLoading());
    final places =
        await HomeRepo.getPlaces(categoryId: categoryId, cityId: cityId);
    places.fold(
      (failuer) => emit(PlacesCubitFailuer(failuer.errorMessage)),
      (places) => emit(PlacesCubitSuccess(places)),
    );
  }
}
