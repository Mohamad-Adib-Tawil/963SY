import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';
import 'package:untitled4/models/place_model.dart';

part 'slider_state.dart';

class SliderCubit extends Cubit<SliderState> {
  SliderCubit(this.homeRepo) : super(SliderInitial());

  final HomeRepo homeRepo;

  Future<void> getSliderImages(int categoryId) async {
    emit(SliderLoading());
    final sliderItems = await homeRepo.getSliderImages(categoryId);
    sliderItems.fold(
        (failuer) => emit(SliderFailuer(errorMessage: failuer.errorMessage)),
        (items) => emit(SliderSuccess(sliderItems: items)));
  }
}
