part of 'language_cubit.dart';

sealed class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

final class LanguageLoading extends LanguageState {}

final class LanguageSucces extends LanguageState {
  final List<LanguageModel> languages;
  const LanguageSucces(this.languages);
}

final class LanguageFailuer extends LanguageState {
  final String errorMessage;

  const LanguageFailuer({required this.errorMessage});
}
