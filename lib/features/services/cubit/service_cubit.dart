import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';
import 'package:untitled4/models/service.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit(this.serviceRepo) : super(ServiceInitial());
  final ServiceRepo serviceRepo;

  Future<void> getCityServices(
      {required int cityId, required int categoryId}) async {
    emit(ServiceLoading());
    final services = await serviceRepo.getCityServices(
        cityID: cityId, categoryId: categoryId);
    services.fold(
      (failuer) => emit(ServiceFailuer(errorMessage: failuer.errorMessage)),
      (services) => emit(ServiceSuccess(services: services)),
    );
  }
}
