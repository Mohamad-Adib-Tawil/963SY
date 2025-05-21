import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/places/data/models/place_details_model.dart';
import 'package:untitled4/features/places/data/repos/place_details_repo.dart';
import 'package:untitled4/models/media.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  PlaceDetailsCubit(this.placeDetailsRepo) : super(PlaceDetailsInitial());
  final PlaceDetailsRepo placeDetailsRepo;

  Future<void> getDetails(
      {required int placeId,
      required int cityId,
      required int categoryId}) async {
    emit(PlaceDetailsLoading());
    final details = await placeDetailsRepo.getDetails(
        placeId: placeId, cityId: cityId, categoryId: categoryId);

    details.fold(
      (failuer) => emit(PlaceDetailsError(errorMessage: failuer.errorMessage)),
      (data) => emit(PlaceDetailsSuccess(placeDetailsModel: data)),
    );
  }
}
