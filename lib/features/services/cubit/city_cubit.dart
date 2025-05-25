
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled4/features/places/data/models/city_model.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';

part 'city_state.dart';

class CityCubit extends Cubit<CityState> {
  CityCubit(this.serviceRepo) : super(CityInitial());
  final ServiceRepo serviceRepo;

  Future<void> getServiceCities(int categoryId) async {
    emit(CityLoading());
    final cities = await serviceRepo.getServiceCities(categoryId: categoryId);
    cities.fold(
        (failuer) => emit(CityFailuer(errorMessage: failuer.errorMessage)),
        (cities) => emit(CitySuccess(cities: cities)));
  }
}
