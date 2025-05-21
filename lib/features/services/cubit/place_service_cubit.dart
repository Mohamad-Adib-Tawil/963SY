
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/services/model/place_of_service/place_of_service.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';

part 'place_service_state.dart';

class PlaceServiceCubit extends Cubit<PlaceServiceState> {
  PlaceServiceCubit(this.serviceRepo) : super(PlaceServiceInitial());

  final ServiceRepo serviceRepo;

  Future<void> getPlaceOfService(
      {required int serviceId,
      required int cityId,
      required categoryId}) async {
    emit(PlaceServiceLoading());
    final placeOfService = await serviceRepo.getPlaceOfService(
        serviceId: serviceId, cityId: cityId, categoryId: categoryId);
    placeOfService.fold(
        (failuer) =>
            emit(PlaceServiceFailuer(errorMessage: failuer.errorMessage)),
        (placeOfService) =>
            emit(PlaceServiceSuccess(placeOfServices: placeOfService)));
  }
}
