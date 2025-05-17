import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit(this.homeRepo) : super(HomeCubitInitial());
  final HomeRepo homeRepo;

  Future<void> getCategories() async {
    emit(HomeCubitLoading());
    final categories = await homeRepo.getCategories();

    categories.fold(
      (failuer) => emit(HomeCubitError(failuer.errorMessage)),
      (categories) => emit(HomeCubitSuccess(categories)),
    );
  }
}
