import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/places/data/repos/place_details_repo.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit(this.placeDetailsRepo) : super(PlaceDetailsInitial());
  final PlaceDetailsRepo placeDetailsRepo;

  Future<void> getMedia(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    emit(PlaceDetailsLoading());
    final media = await placeDetailsRepo.getMedia(
        placeId: placeId, cityId: cityId, categoryId: categoryId);
    media.fold(
      (failuer) => emit(PlaceDetailsError(errorMessage: failuer.errorMessage)),
      (media) => emit(PlaceDetailsSuccess(data: media)),
    );
  }

  Future<void> getLinks(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    emit(PlaceDetailsLoading());
    final link = await placeDetailsRepo.getLinks(
        placeId: placeId, cityId: cityId, categoryId: categoryId);
    link.fold(
      (failuer) => emit(PlaceDetailsError(errorMessage: failuer.errorMessage)),
      (link) => emit(PlaceDetailsSuccess(data: link)),
    );
  }
}
