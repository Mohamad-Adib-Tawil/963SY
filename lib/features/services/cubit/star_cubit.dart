import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/services/model/star_model.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';

part 'star_state.dart';

class StarCubit extends Cubit<StarState> {
  StarCubit(this.serviceRepo) : super(StarInitial());

  final ServiceRepo serviceRepo;

  Future<void> getStars(
      {required int serviceId,
      required int cityId,
      required categoryId}) async {
    emit(StarLoading());
    final stars = await serviceRepo.getServiceStars(
        serviceId: serviceId, cityId: cityId, categoryId: categoryId);
    stars.fold(
      (failuer) => emit(StarFailuer(errorMessage: failuer.errorMessage)),
      (stars) => emit(StarsSuccess(stars: stars)),
    );
  }
}
