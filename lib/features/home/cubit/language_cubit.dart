import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/home/models/language_model.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(this.homeRepo) : super(LanguageInitial());
  final HomeRepo homeRepo;

  Future<void> getLanguages() async {
    emit(LanguageLoading());
    final languages = await homeRepo.getLanguages();
    languages.fold(
      (failuer) => emit(LanguageFailuer(errorMessage: failuer.errorMessage)),
      (languages) => emit(LanguageSucces(languages)),
    );
  }
}
